GLOBALS

#
# Global WebService error structure
# Check the contents of this structure for a detailed error description
# when a WebService function returns with a non-zero status.
#

DEFINE wsError RECORD
	code		STRING,
	codeNS		STRING,
	description	STRING,
	action		STRING
END RECORD




#
# Global Endpoint user-defined type definition
#
TYPE tGlobalEndpointType RECORD	 # End point
	Address	RECORD	# Address
		Uri	STRING	# URI 
	END RECORD,
	Binding	RECORD	# Binding
		Version	STRING,	# HTTP Version (1.0 or 1.1)
		Cookie	STRING,	# Cookie to be set
		ConnectionTimeout	INTEGER,# Connection timeout
		ReadWriteTimeout	INTEGER	# Read write timeout
	END RECORD
END RECORD


#-------------------------------------------------------------------------------
# Service: PushServiceSoapService
# Port:    PushServiceSoapPortType
# Server:  undefined
#-------------------------------------------------------------------------------
#
# Location of the SOAP endpoint.
# You MUST assign this value.
#
DEFINE awsp900_05_PushServiceSoapService_PushServiceSoapPortTypeEndpoint tGlobalEndpointType

#-------------------------------------------------------------------------------
#
# Operation: RegistPNDevice
#
# FUNCTION: awsp900_05_RegistPNDevice_g()
#   RETURNING: soapStatus
#   INPUT: GLOBAL awsp900_05_RegistPNDevice
#   OUTPUT: GLOBAL awsp900_05_RegistPNDeviceResponse
#
# FUNCTION: awsp900_05_RegistPNDevice(p_pKey, p_pTransData)
#   RETURNING: soapStatus ,p_RegistPNDeviceResult
#
# FUNCTION: awsp900_05_RegistPNDeviceRequest_g()
#   RETURNING: soapStatus
#   INPUT: GLOBAL awsp900_05_RegistPNDevice
#
# FUNCTION: awsp900_05_RegistPNDeviceResponse_g()
#   RETURNING: soapStatus
#   OUTPUT: GLOBAL awsp900_05_RegistPNDeviceResponse
#

#-------------------------------------------------------------------------------

# VARIABLE : awsp900_05_RegistPNDevice
DEFINE awsp900_05_RegistPNDevice RECORD ATTRIBUTE(XMLSequence,XMLName="RegistPNDevice",XMLNamespace="http://tempuri.org/")
         pKey STRING ATTRIBUTE(XMLName="pKey",XMLOptional),
         pTransData STRING ATTRIBUTE(XMLName="pTransData",XMLOptional)
       END RECORD


#-------------------------------------------------------------------------------

# VARIABLE : awsp900_05_RegistPNDeviceResponse
DEFINE awsp900_05_RegistPNDeviceResponse RECORD ATTRIBUTE(XMLSequence,XMLName="RegistPNDeviceResponse",XMLNamespace="http://tempuri.org/")
         RegistPNDeviceResult STRING ATTRIBUTE(XMLName="RegistPNDeviceResult",XMLOptional)
       END RECORD

#-------------------------------------------------------------------------------
#
# Operation: RegistGuestToken
#
# FUNCTION: awsp900_05_RegistGuestToken_g()
#   RETURNING: soapStatus
#   INPUT: GLOBAL awsp900_05_RegistGuestToken
#   OUTPUT: GLOBAL awsp900_05_RegistGuestTokenResponse
#
# FUNCTION: awsp900_05_RegistGuestToken(p_pKey, p_pTransData)
#   RETURNING: soapStatus ,p_RegistGuestTokenResult
#
# FUNCTION: awsp900_05_RegistGuestTokenRequest_g()
#   RETURNING: soapStatus
#   INPUT: GLOBAL awsp900_05_RegistGuestToken
#
# FUNCTION: awsp900_05_RegistGuestTokenResponse_g()
#   RETURNING: soapStatus
#   OUTPUT: GLOBAL awsp900_05_RegistGuestTokenResponse
#

#-------------------------------------------------------------------------------

# VARIABLE : awsp900_05_RegistGuestToken
DEFINE awsp900_05_RegistGuestToken RECORD ATTRIBUTE(XMLSequence,XMLName="RegistGuestToken",XMLNamespace="http://tempuri.org/")
         pKey STRING ATTRIBUTE(XMLName="pKey",XMLOptional),
         pTransData STRING ATTRIBUTE(XMLName="pTransData",XMLOptional)
       END RECORD


#-------------------------------------------------------------------------------

# VARIABLE : awsp900_05_RegistGuestTokenResponse
DEFINE awsp900_05_RegistGuestTokenResponse RECORD ATTRIBUTE(XMLSequence,XMLName="RegistGuestTokenResponse",XMLNamespace="http://tempuri.org/")
         RegistGuestTokenResult STRING ATTRIBUTE(XMLName="RegistGuestTokenResult",XMLOptional)
       END RECORD

#-------------------------------------------------------------------------------
#
# Operation: PushDevicePMG
#
# FUNCTION: awsp900_05_PushDevicePMG_g()
#   RETURNING: soapStatus
#   INPUT: GLOBAL awsp900_05_PushDevicePMG
#   OUTPUT: GLOBAL awsp900_05_PushDevicePMGResponse
#
# FUNCTION: awsp900_05_PushDevicePMG(p_pKey, p_pPushMsg)
#   RETURNING: soapStatus ,p_PushDevicePMGResult
#
# FUNCTION: awsp900_05_PushDevicePMGRequest_g()
#   RETURNING: soapStatus
#   INPUT: GLOBAL awsp900_05_PushDevicePMG
#
# FUNCTION: awsp900_05_PushDevicePMGResponse_g()
#   RETURNING: soapStatus
#   OUTPUT: GLOBAL awsp900_05_PushDevicePMGResponse
#

#-------------------------------------------------------------------------------

# VARIABLE : awsp900_05_PushDevicePMG
DEFINE awsp900_05_PushDevicePMG RECORD ATTRIBUTE(XMLSequence,XMLName="PushDevicePMG",XMLNamespace="http://tempuri.org/")
         pKey STRING ATTRIBUTE(XMLName="pKey",XMLOptional),
         pPushMsg STRING ATTRIBUTE(XMLName="pPushMsg",XMLOptional)
       END RECORD


#-------------------------------------------------------------------------------

# VARIABLE : awsp900_05_PushDevicePMGResponse
DEFINE awsp900_05_PushDevicePMGResponse RECORD ATTRIBUTE(XMLSequence,XMLName="PushDevicePMGResponse",XMLNamespace="http://tempuri.org/")
         PushDevicePMGResult STRING ATTRIBUTE(XMLName="PushDevicePMGResult",XMLOptional)
       END RECORD

#-------------------------------------------------------------------------------
#
# Operation: UpdateGProgramBgNumber
#
# FUNCTION: awsp900_05_UpdateGProgramBgNumber_g()
#   RETURNING: soapStatus
#   INPUT: GLOBAL awsp900_05_UpdateGProgramBgNumber
#   OUTPUT: GLOBAL awsp900_05_UpdateGProgramBgNumberResponse
#
# FUNCTION: awsp900_05_UpdateGProgramBgNumber(p_pBgP2M)
#   RETURNING: soapStatus ,p_UpdateGProgramBgNumberResult
#
# FUNCTION: awsp900_05_UpdateGProgramBgNumberRequest_g()
#   RETURNING: soapStatus
#   INPUT: GLOBAL awsp900_05_UpdateGProgramBgNumber
#
# FUNCTION: awsp900_05_UpdateGProgramBgNumberResponse_g()
#   RETURNING: soapStatus
#   OUTPUT: GLOBAL awsp900_05_UpdateGProgramBgNumberResponse
#

#-------------------------------------------------------------------------------

# VARIABLE : awsp900_05_UpdateGProgramBgNumber
DEFINE awsp900_05_UpdateGProgramBgNumber RECORD ATTRIBUTE(XMLSequence,XMLName="UpdateGProgramBgNumber",XMLNamespace="http://tempuri.org/")
         pBgP2M STRING ATTRIBUTE(XMLName="pBgP2M",XMLOptional)
       END RECORD


#-------------------------------------------------------------------------------

# VARIABLE : awsp900_05_UpdateGProgramBgNumberResponse
DEFINE awsp900_05_UpdateGProgramBgNumberResponse RECORD ATTRIBUTE(XMLSequence,XMLName="UpdateGProgramBgNumberResponse",XMLNamespace="http://tempuri.org/")
         UpdateGProgramBgNumberResult STRING ATTRIBUTE(XMLName="UpdateGProgramBgNumberResult",XMLOptional)
       END RECORD

#-------------------------------------------------------------------------------
#
# Operation: PushMessageByToken
#
# FUNCTION: awsp900_05_PushMessageByToken_g()
#   RETURNING: soapStatus
#   INPUT: GLOBAL awsp900_05_PushMessageByToken
#   OUTPUT: GLOBAL awsp900_05_PushMessageByTokenResponse
#
# FUNCTION: awsp900_05_PushMessageByToken(p_pKey, p_pPushMsg)
#   RETURNING: soapStatus ,p_PushMessageByTokenResult
#
# FUNCTION: awsp900_05_PushMessageByTokenRequest_g()
#   RETURNING: soapStatus
#   INPUT: GLOBAL awsp900_05_PushMessageByToken
#
# FUNCTION: awsp900_05_PushMessageByTokenResponse_g()
#   RETURNING: soapStatus
#   OUTPUT: GLOBAL awsp900_05_PushMessageByTokenResponse
#

#-------------------------------------------------------------------------------

# VARIABLE : awsp900_05_PushMessageByToken
DEFINE awsp900_05_PushMessageByToken RECORD ATTRIBUTE(XMLSequence,XMLName="PushMessageByToken",XMLNamespace="http://tempuri.org/")
         pKey STRING ATTRIBUTE(XMLName="pKey",XMLOptional),
         pPushMsg STRING ATTRIBUTE(XMLName="pPushMsg",XMLOptional)
       END RECORD


#-------------------------------------------------------------------------------

# VARIABLE : awsp900_05_PushMessageByTokenResponse
DEFINE awsp900_05_PushMessageByTokenResponse RECORD ATTRIBUTE(XMLSequence,XMLName="PushMessageByTokenResponse",XMLNamespace="http://tempuri.org/")
         PushMessageByTokenResult STRING ATTRIBUTE(XMLName="PushMessageByTokenResult",XMLOptional)
       END RECORD



END GLOBALS
