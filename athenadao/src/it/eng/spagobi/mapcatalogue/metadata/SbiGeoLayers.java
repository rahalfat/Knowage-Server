/* SpagoBI, the Open Source Business Intelligence suite

 * Copyright (C) 2012 Engineering Ingegneria Informatica S.p.A. - SpagoBI Competency Center
 * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0, without the "Incompatible With Secondary Licenses" notice.
 * If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package it.eng.spagobi.mapcatalogue.metadata;

import java.util.List;

import it.eng.spagobi.commons.metadata.SbiDomains;
import it.eng.spagobi.commons.metadata.SbiExtRoles;
import it.eng.spagobi.commons.metadata.SbiHibernateModel;
import it.eng.spagobi.mapcatalogue.bo.GeoLayer;

public class SbiGeoLayers extends SbiHibernateModel {

	private static final long serialVersionUID = 9129008218416362745L;
	private int layerId;
	private String name;
	private String descr;
	private String type;
	private boolean baseLayer = false;
	private String label;
	private byte[] layerDef;
	private byte[] bodyFile;
	private int layerOrder;
	private Integer category_id;
	private SbiDomains category;
	private List<SbiExtRoles> roles;

	public SbiGeoLayers() {
		super();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public int getLayerId() {
		return layerId;
	}

	public void setLayerId(int layerId) {
		this.layerId = layerId;
	}

	public byte[] getLayerDef() {
		return layerDef;
	}

	public void setLayerDef(byte[] layerDef) {
		this.layerDef = layerDef;
	}

	/**
	 * @return the isBaseLayer
	 */
	public boolean isBaseLayer() {
		return baseLayer;
	}

	/**
	 * @param isBaseLayer
	 *            the isBaseLayer to set
	 */
	public void setBaseLayer(boolean baseLayer) {
		this.baseLayer = baseLayer;
	}

	public int getLayerOrder() {
		return layerOrder;
	}

	public void setLayerOrder(int layerOrder) {
		this.layerOrder = layerOrder;
	}

	public SbiDomains getCategory() {
		return category;
	}

	public void setCategory(SbiDomains category) {
		this.category = category;
	}

	public Integer getCategory_id() {
		return category_id;
	}

	public void setCategory_id(Integer category_id) {
		this.category_id = category_id;
	}

	public List<SbiExtRoles> getRoles() {
		return roles;
	}

	public void setRoles(List<SbiExtRoles> roles) {
		this.roles = roles;
	}

	public byte[] getBodyFile() {
		return bodyFile;
	}

	public void setBodyFile(byte[] bodyFile) {
		this.bodyFile = bodyFile;
	}

	public GeoLayer toGeoLayer() {
		GeoLayer geo = new GeoLayer();
		geo.setDescr(getDescr());
		geo.setLabel(label);
		geo.setFilebody(bodyFile);
		geo.setName(name);
		geo.setType(type);
		geo.setLayerDef(layerDef);
		geo.setLayerId(layerId);
		geo.setBaseLayer(baseLayer);
		geo.setLayerOrder(layerOrder);
		geo.setCategory(category);
		geo.setCategory_id(category_id);

		geo.setRoles(roles);

		return geo;
	}

}
