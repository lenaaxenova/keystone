--local BaseDao = require "kong.dao.cassandra.base_dao"


local USER_SCHEMA = {
  primary_key = {"user_id"},
  table = "keystone_user_info",
  fields = {
    user_id = { type = "id" },
    tenant_id = { type = "id", required = true },
    user_name = { type = "string", required = true, unique = true },
    password = { type = "string", required = true },
    email = { type = "string", required = true },
    enabled = { type = "boolean", default = true }
  }
}

local UNAME_TO_UID_SCHEMA = {
  primary_key = {"user_name"},
  table = "keystone_uname_to_uid",
  fields = {
    user_name = { type = "string" },
    user_id = { type = "id", required = true, unique = true }
  }
}

local TENNAME_TO_TENID_SCHEMA = {
  primary_key = {"tenant_name"},
  table = "keystone_tenname_to_tenid",
  fields = {
    tenant_name = { type = "string" },
    tenant_id = { type = "id", required = true, unique = true }
  }
}

local TENANT_SCHEMA = {
  primary_key = {"tenant_id"},
  table = "keystone_tenant_info",
  fields = {
    tenant_id = { type = "id", required = true }, 
    tenant_name = { type = "string", required = true, unique = true },
    description = { type = "string" },
    enabled = { type = "boolean", default = true }
  }
}

local TOKEN_SCHEMA = {
  primary_key = {"token_id"},
  table = "keystone_token_info",
  fields = {
    token_id = { type = "id"},
    user_id = { type = "id", required = true },
    tenant_id = { type = "id", required = true },
    issued_at = { type = "timestamp", required = true },
    expires = { type = "timestamp", required = true }
  }
}


--[[

local KeystoneTenant = BaseDao:extend()
local KeystoneUser = BaseDao:extend()
local KeystoneToken = BaseDao:extend()
local KeystoneTennameToTenid = BaseDao:extend()
local KeystoneUnameToUid = BaseDao:extend()

function KeystoneTenant:new(cassandra_properties)
  self._table = "keystone_tenant_info"
  self._schema = TENANT_SCHEMA
  
  Keystone.super.new(self, cassandra_properties)
end

function KeystoneUser:new(cassandra_properties)
  self._table = "keystone_user_info"
  self._schema = USER_SCHEMA
 
  Keystone.super.new(self, cassandra_properties)
end

function KeystoneToken:new(cassandra_properties)
  self._table = "keystone_token_info"
  self._schema = TOKEN_SCHEMA
 
  Keystone.super.new(self, cassandra_properties)
end

function KeystoneTennameToTenid:new(cassandra_properties)
  self._table = "keystone_tenname_to_tenid"
  self._schema = TENNAME_TO_TENID_SCHEMA
 
  Keystone.super.new(self, cassandra_properties)
end

function KeystoneUnameToUid:new(cassandra_properties)
  self._table = "keystone_uname_to_uid"
  self._schema = UNAME_TO_UID_SCHEMA
 
  Keystone.super.new(self, cassandra_properties)
end

return {
  keystone_user_info = KeystoneUser,
  keystone_tenant_info = KeystoneTenant,
  keystone_token_info = KeystoneToken,
  keystone_uname_to_uid = KeystoneUnameToUid,
  keystone_tenname_to_tenid = KeystoneTennameToTenid
} ]]--


return {
  keystone_user_info = USER_SCHEMA,
  keystone_tenant_info = TENANT_SCHEMA,
  keystone_token_info = TOKEN_SCHEMA,
  keystone_uname_to_uid = UNAME_TO_UID_SCHEMA,
  keystone_tenname_to_tenid = TENNAME_TO_TENID_SCHEMA
}

