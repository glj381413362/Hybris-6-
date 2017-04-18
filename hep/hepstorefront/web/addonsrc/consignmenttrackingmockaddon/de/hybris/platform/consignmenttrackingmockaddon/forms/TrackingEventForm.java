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
package de.hybris.platform.consignmenttrackingmockaddon.forms;

import java.util.Date;


/**
 * A mock form for TrackingEvent
 */
public class TrackingEventForm
{
	private String eventLocation;
	private String eventDetail;
	private String consignmentStatus;
	private String trackingId;
	private Date eventDate;


	public String getEventLocation()
	{
		return eventLocation;
	}

	public void setEventLocation(final String eventLocation)
	{
		this.eventLocation = eventLocation;
	}

	public String getEventDetail()
	{
		return eventDetail;
	}

	public void setEventDetail(final String eventDetail)
	{
		this.eventDetail = eventDetail;
	}

	public String getConsignmentStatus()
	{
		return consignmentStatus;
	}

	public void setConsignmentStatus(final String consignmentStatus)
	{
		this.consignmentStatus = consignmentStatus;
	}

	public String getTrackingId()
	{
		return trackingId;
	}

	public void setTrackingId(String trackingId)
	{
		this.trackingId = trackingId;
	}

	public Date getEventDate()
	{
		return eventDate;
	}

	public void setEventDate(Date eventDate)
	{
		this.eventDate = eventDate;
	}


}
