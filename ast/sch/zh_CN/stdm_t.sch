/* 
================================================================================
檔案代號:stdm_t
檔案名稱:聯營結算單生成方式配置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table stdm_t
(
stdment       number(5)      ,/* 企業代碼 */
stdmunit       varchar2(10)      ,/* 應用組織 */
stdmsite       varchar2(10)      ,/* 營運據點 */
stdm001       varchar2(10)      ,/* 專櫃編號 */
stdm002       varchar2(20)      ,/* 合同編號 */
stdm003       varchar2(10)      ,/* 供應商編號 */
stdm004       varchar2(1)      ,/* 多門店同法人合併否 */
stdm005       varchar2(1)      ,/* 管理品類拆分否 */
stdm006       varchar2(1)      /* 不同品牌拆分否 */
);
alter table stdm_t add constraint stdm_pk primary key (stdment,stdm001) enable validate;

create unique index stdm_pk on stdm_t (stdment,stdm001);

grant select on stdm_t to tiptop;
grant update on stdm_t to tiptop;
grant delete on stdm_t to tiptop;
grant insert on stdm_t to tiptop;

exit;
