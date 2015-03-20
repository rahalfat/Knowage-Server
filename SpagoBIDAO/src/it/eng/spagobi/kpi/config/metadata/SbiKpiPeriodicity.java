/* SpagoBI, the Open Source Business Intelligence suite

 * Copyright (C) 2012 Engineering Ingegneria Informatica S.p.A. - SpagoBI Competency Center
 * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0, without the "Incompatible With Secondary Licenses" notice. 
 * If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/. */
package it.eng.spagobi.kpi.config.metadata;
// Generated 2-dic-2008 10.47.59 by Hibernate Tools 3.1.0 beta3

import it.eng.spagobi.commons.metadata.SbiHibernateModel;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;


/**
 * SbiKpiPeriodicity generated by hbm2java
 */

public class SbiKpiPeriodicity  extends SbiHibernateModel {


    // Fields    

     private Integer idKpiPeriodicity;
     private String name;
     private Integer months;
     private Integer days;
     private Integer hours;
     private Integer minutes;
     private String chronString;
     private Date startDate;
     private Set sbiKpiInstPeriods = new HashSet(0);


    // Constructors

    /** default constructor */
    public SbiKpiPeriodicity() {
    }

	/** minimal constructor */
    public SbiKpiPeriodicity(Integer idKpiPeriodicity) {
        this.idKpiPeriodicity = idKpiPeriodicity;
    }
    
    /** full constructor */
    public SbiKpiPeriodicity(Integer idKpiPeriodicity, String name, Integer months, Integer days, Integer hours, Integer minutes, String chronString, Date startDate, Set sbiKpiInstPeriods) {
        this.idKpiPeriodicity = idKpiPeriodicity;
        this.name = name;
        this.months = months;
        this.days = days;
        this.hours = hours;
        this.minutes = minutes;
        this.chronString = chronString;
        this.startDate = startDate;
        this.sbiKpiInstPeriods = sbiKpiInstPeriods;
    }
    

   
    // Property accessors

    public Integer getIdKpiPeriodicity() {
        return this.idKpiPeriodicity;
    }
    
    public void setIdKpiPeriodicity(Integer idKpiPeriodicity) {
        this.idKpiPeriodicity = idKpiPeriodicity;
    }

    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }

    public Integer getMonths() {
        return this.months;
    }
    
    public void setMonths(Integer months) {
        this.months = months;
    }

    public Integer getDays() {
        return this.days;
    }
    
    public void setDays(Integer days) {
        this.days = days;
    }

    public Integer getHours() {
        return this.hours;
    }
    
    public void setHours(Integer hours) {
        this.hours = hours;
    }

    public Integer getMinutes() {
        return this.minutes;
    }
    
    public void setMinutes(Integer minutes) {
        this.minutes = minutes;
    }

    public String getChronString() {
        return this.chronString;
    }
    
    public void setChronString(String chronString) {
        this.chronString = chronString;
    }

    public Date getStartDate() {
        return this.startDate;
    }
    
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Set getSbiKpiInstPeriods() {
        return this.sbiKpiInstPeriods;
    }
    
    public void setSbiKpiInstPeriods(Set sbiKpiInstPeriods) {
        this.sbiKpiInstPeriods = sbiKpiInstPeriods;
    }
   
}