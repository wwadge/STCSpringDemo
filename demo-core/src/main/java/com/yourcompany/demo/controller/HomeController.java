package com.yourcompany.demo.controller;

import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yourcompany.demo.controller.dto.AppointmentDTO;
import com.yourcompany.demo.controller.dto.CustomerDTO;
import com.yourname.demo.model.Appointment;
import com.yourname.demo.model.Customer;
import com.yourname.demo.model.factories.ServiceSchedulingSystemDataPoolFactory;
import com.yourname.demo.service.data.DataLayerServiceSchedulingSystem;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	DataLayerServiceSchedulingSystem dataLayer;
	
	
	@Transactional
	@RequestMapping(value = "/getCustomerList", method = RequestMethod.GET)
	public @ResponseBody List<CustomerDTO> getCustomerList(Model model) {
//		Customer c = ServiceSchedulingSystemDataPoolFactory.getCustomer();
//		dataLayer.saveOrUpdate(c);
//		for (int i=0; i < 5; i++){
//			Appointment a = ServiceSchedulingSystemDataPoolFactory.getAppointment();
//			a.setCustomer(c);
//			dataLayer.saveOrUpdate(a);
//		}
		
		List<CustomerDTO> result = new LinkedList<CustomerDTO>();
		List<Customer> customerList = dataLayer.createQuery("from Customer").list();
		for (Customer c: customerList){
			CustomerDTO cdto = new CustomerDTO();
			cdto.id=c.getId();
			cdto.name=c.getName();
			result.add(cdto);
		}

		return result;
	}
	
	@Transactional
	@RequestMapping(value = "/getCustomerAppointments", method = RequestMethod.GET)
	public @ResponseBody List<AppointmentDTO> getCustomerAppointments(@RequestParam Long custId, Model model) {
		List<Appointment> appointments =  dataLayer.createQuery("from Appointment a where a.customer.id = :custId ").setParameter("custId", custId).list();
		List<AppointmentDTO> result = new LinkedList<AppointmentDTO>();
		for (Appointment a: appointments){
			AppointmentDTO adto = new AppointmentDTO();
			adto.setId(a.getId());
			adto.setStartDate(a.getStartDate());
			adto.setEndDate(a.getEndDate());
			result.add(adto);
		}
		
		return result;
		
	}
	
	@Transactional
	@RequestMapping(value = "/deleteAppointment", method = RequestMethod.POST)
	public @ResponseBody void deleteAppointment(@RequestParam("appointmentId") Long appointmentId, Model model) {
		Appointment a = dataLayer.loadAppointment(appointmentId);
		a.getCustomer().getAppointments().remove(a);	
		dataLayer.deleteAppointment(appointmentId);
	}
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Transactional
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale) {
		// this is just for a test, normally you'd have to load customer first
		Customer customer = ServiceSchedulingSystemDataPoolFactory.getCustomer();
		
		Appointment appt = new Appointment();
		appt.setCustomer(customer);
		
		
		ModelAndView mv = new ModelAndView("home");
		mv.addObject("appointment", appt);
		
		return mv;
	}
	

	/**
	 */
	@Transactional
	@RequestMapping(value = "/addAppointment", method = RequestMethod.GET)
	public String home(@RequestParam Long customerId, Model model) {
		AppointmentDTO adto = new AppointmentDTO();
		adto.setCustomerId(customerId);
		model.addAttribute("appointment", adto);
		model.addAttribute("services", dataLayer.createQuery("from Service").list());
		return "addAppointment";
	}

	/**
	 */
	@Transactional
	@RequestMapping(value = "/addAppointment", method = RequestMethod.POST)
	public String home(@Valid @ModelAttribute AppointmentDTO appt, BindingResult result) {
		System.out.println(appt);
		Appointment a = new Appointment();
		a.setCustomer(dataLayer.loadCustomer(appt.getCustomerId()));
		a.setStartDate(appt.getStartDate());
		a.setEndDate(appt.getEndDate());
		dataLayer.saveOrUpdate(a);
		return "home"; //ok
	}
	



	
}
