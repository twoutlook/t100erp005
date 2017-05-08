/* 
================================================================================
檔案代號:fmbj_t
檔案名稱:基准利率维护檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fmbj_t
(
fmbjent       number(5)      ,/* 企業代碼 */
fmbjownid       varchar2(20)      ,/* 資料所有者 */
fmbjowndp       varchar2(10)      ,/* 資料所屬部門 */
fmbjcrtid       varchar2(20)      ,/* 資料建立者 */
fmbjcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmbjcrtdt       timestamp(0)      ,/* 資料創建日 */
fmbjmodid       varchar2(20)      ,/* 資料修改者 */
fmbjmoddt       timestamp(0)      ,/* 最近修改日 */
fmbjstus       varchar2(10)      ,/* 狀態碼 */
fmbj001       varchar2(10)      ,/* 國家或地區 */
fmbj002       date      ,/* 日期 */
fmbj003       varchar2(1)      ,/* 類別 */
fmbj004       varchar2(10)      ,/* 幣別 */
fmbj005       number(10,6)      /* 基準利率 */
);
alter table fmbj_t add constraint fmbj_pk primary key (fmbjent,fmbj001,fmbj002,fmbj003,fmbj004) enable validate;

create unique index fmbj_pk on fmbj_t (fmbjent,fmbj001,fmbj002,fmbj003,fmbj004);

grant select on fmbj_t to tiptop;
grant update on fmbj_t to tiptop;
grant delete on fmbj_t to tiptop;
grant insert on fmbj_t to tiptop;

exit;
