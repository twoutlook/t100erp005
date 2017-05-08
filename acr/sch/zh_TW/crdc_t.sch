/* 
================================================================================
檔案代號:crdc_t
檔案名稱:會員價值評估記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table crdc_t
(
crdcent       number(5)      ,/* 企業編號 */
crdc001       varchar2(30)      ,/* 會員編號 */
crdc002       number(5,0)      ,/* 年度 */
crdc003       number(5,0)      ,/* 期別 */
crdc004       varchar2(40)      ,/* 會員等級 */
crdc005       number(15,3)      ,/* R值 */
crdc006       number(15,3)      ,/* F值 */
crdc007       number(20,6)      ,/* M值 */
crdc008       varchar2(3)      ,/* RFM等級標識 */
crdc009       number(15,3)      ,/* RFM得分 */
crdc010       varchar2(10)      ,/* 會員價值 */
crdc011       timestamp(0)      ,/* 評估日期 */
crdc012       varchar2(20)      ,/* 評估人員 */
crdc013       varchar2(40)      ,/* 備用一 */
crdc014       varchar2(40)      ,/* 備用二 */
crdc015       varchar2(40)      /* 備用三 */
);
alter table crdc_t add constraint crdc_pk primary key (crdcent,crdc001,crdc002,crdc003) enable validate;

create unique index crdc_pk on crdc_t (crdcent,crdc001,crdc002,crdc003);

grant select on crdc_t to tiptop;
grant update on crdc_t to tiptop;
grant delete on crdc_t to tiptop;
grant insert on crdc_t to tiptop;

exit;
