/*
 * [y] hybris Platform
 *
 * Copyright (c) 2017 SAP SE or an SAP affiliate company.  All rights reserved.
 *
 * This software is the confidential and proprietary information of SAP
 * ("Confidential Information"). You shall not disclose such Confidential
 * Information and shall use it only in accordance with the terms of the
 * license agreement you entered into with SAP.
 */
package de.hybris.platform.consignmenttrackingmockaddon.controllers.pages;

import de.hybris.platform.basecommerce.enums.ConsignmentStatus;
import de.hybris.platform.consignmenttrackingmockaddon.controllers.ConsignmenttrackingmockaddonControllerConstants;
import de.hybris.platform.consignmenttrackingmockaddon.data.MockDataProvider;
import de.hybris.platform.consignmenttrackingmockaddon.forms.TrackingEventForm;
import de.hybris.platform.consignmenttrackingservices.delivery.data.ConsignmentEventData;
import de.hybris.platform.consignmenttrackingservices.service.ConsignmentTrackingService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * A mock tracking events querying interface of carrier.
 */
@Controller
@RequestMapping("/tracking/mock")
public class MockCarrierController
{

	@Resource(name = "consignmentTrackingService")
	private ConsignmentTrackingService consignmentTrackingService;

	@Resource(name = "mockDataProvider")
	private MockDataProvider mockDataProvider;

	@Resource(name = "carrier")
	private String carrier;

	private final Map<String, List<ConsignmentEventData>> trackingEvents = new HashMap<>();

	@ResponseBody
	@RequestMapping(value = "/events/{trackingId}", method = RequestMethod.GET, produces = "application/json")
	public List<ConsignmentEventData> retrieveTrackingEvents(@PathVariable("trackingId") final String trackingId)
			throws IOException
	{
		return trackingEvents.getOrDefault(trackingId, Collections.emptyList());
	}

	@RequestMapping(value = "/events", method = RequestMethod.GET)
	public String redirectToMockCarrier() throws IOException
	{
		return ConsignmenttrackingmockaddonControllerConstants.Pages.MockCarrierPage;
	}

	@RequestMapping(method = RequestMethod.GET)
	public String display(final Model model)
	{
		final List<ConsignmentStatus> statuses = new ArrayList<>();
		statuses.add(ConsignmentStatus.IN_TRANSIT);
		statuses.add(ConsignmentStatus.DELIVERING);
		statuses.add(ConsignmentStatus.DELIVERY_COMPLETED);
		statuses.add(ConsignmentStatus.DELIVERY_REJECTED);
		model.addAttribute("statuses", statuses);
		model.addAttribute("carrier", carrier);
		return ConsignmenttrackingmockaddonControllerConstants.Pages.ConsignmentMockPage;
	}

	@RequestMapping(method = RequestMethod.POST)
	public String prepare(final TrackingEventForm form)
	{

		final String trackingId = form.getTrackingId();
		mockDataProvider.getConsignmentForTrackingId(carrier, trackingId).ifPresent(consignment -> {

			final String consignmentCode = consignment.getCode();
			final String orderCode = consignment.getOrder().getCode();
			final List<ConsignmentEventData> consignmentEvents = trackingEvents.getOrDefault(trackingId, new ArrayList<>());

			final ConsignmentEventData consignmentEvent = new ConsignmentEventData();
			consignmentEvent.setDetail(form.getEventDetail());
			consignmentEvent.setLocation(form.getEventLocation());
			consignmentEvent.setReferenceCode(form.getConsignmentStatus());

			final Calendar calendar = Calendar.getInstance();
			final int minute = calendar.get(Calendar.MINUTE);
			calendar.setTime(form.getEventDate());
			calendar.set(Calendar.MINUTE, minute);
			consignmentEvent.setEventDate(calendar.getTime());

			consignmentEvents.add(consignmentEvent);
			trackingEvents.put(trackingId, consignmentEvents);

			consignmentTrackingService.updateConsignmentStatusForCode(orderCode, consignmentCode,
					ConsignmentStatus.valueOf(form.getConsignmentStatus()));
		});

		return "redirect:/tracking/mock";
	}
}
