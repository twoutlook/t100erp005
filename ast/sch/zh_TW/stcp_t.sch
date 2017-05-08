/* 
================================================================================
檔案代號:stcp_t
檔案名稱:分銷客戶合作產品統計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table stcp_t
(
stcpent       number(5)      ,/* 企業編號 */
stcpunit       varchar2(10)      ,/* 應用組織 */
stcpsite       varchar2(10)      ,/* 營運據點 */
stcp001       varchar2(10)      ,/* 對象類型 */
stcp002       varchar2(10)      ,/* 經銷商 */
stcp003       varchar2(10)      ,/* 網點 */
stcp004       varchar2(10)      ,/* 經營方式 */
stcp005       varchar2(40)      /* 產品編號 */
);
alter table stcp_t add constraint stcp_pk primary key (stcpent,stcpsite,stcp001,stcp002,stcp003,stcp004,stcp005) enable validate;

create unique index stcp_pk on stcp_t (stcpent,stcpsite,stcp001,stcp002,stcp003,stcp004,stcp005);

grant select on stcp_t to tiptop;
grant update on stcp_t to tiptop;
grant delete on stcp_t to tiptop;
grant insert on stcp_t to tiptop;

exit;
