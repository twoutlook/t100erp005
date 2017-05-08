PUBLIC TYPE T_UPLOAD_PARAM RECORD
              arg1_program_name     VARCHAR(50),                    
              arg2_module_name      VARCHAR(10),               
              arg3_upload_doc_type  VARCHAR(10),
              arg4_client_path      VARCHAR(1024),                
              arg5_spec_version     VARCHAR(20),                
              arg6_code_version     VARCHAR(20),
              arg7_std_program      VARCHAR(50),                    
              arg8_std_spec_version VARCHAR(20),                
              arg9_std_code_version VARCHAR(20),
              arg10_dgenv           VARCHAR(5),
              arg11_type            VARCHAR(5)
            END RECORD
