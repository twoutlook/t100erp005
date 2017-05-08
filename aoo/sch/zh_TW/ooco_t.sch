/* 
================================================================================
檔案代號:ooco_t
檔案名稱:街道資料主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table ooco_t
(
oocoent       number(5)      ,/* 企業代碼 */
oocostus       varchar2(10)      ,/* 狀態碼 */
ooco001       varchar2(10)      ,/* 國家地區編號 */
ooco002       varchar2(10)      ,/* 州省編號 */
ooco003       varchar2(10)      ,/* 縣市編號 */
ooco004       varchar2(10)      ,/* 行政地區編號 */
ooco005       varchar2(10)      ,/* 街道編號 */
oocoownid       varchar2(20)      ,/* 資料所有者 */
oocoowndp       varchar2(10)      ,/* 資料所屬部門 */
oococrtid       varchar2(20)      ,/* 資料建立者 */
oococrtdp       varchar2(10)      ,/* 資料建立部門 */
oococrtdt       timestamp(0)      ,/* 資料創建日 */
oocomodid       varchar2(20)      ,/* 資料修改者 */
oocomoddt       timestamp(0)      /* 最近修改日 */
);
alter table ooco_t add constraint ooco_pk primary key (oocoent,ooco001,ooco002,ooco003,ooco004,ooco005) enable validate;

create unique index ooco_pk on ooco_t (oocoent,ooco001,ooco002,ooco003,ooco004,ooco005);

grant select on ooco_t to tiptop;
grant update on ooco_t to tiptop;
grant delete on ooco_t to tiptop;
grant insert on ooco_t to tiptop;

exit;
