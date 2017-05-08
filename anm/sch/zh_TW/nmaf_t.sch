/* 
================================================================================
檔案代號:nmaf_t
檔案名稱:銀行支票簿資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmaf_t
(
nmafent       number(5)      ,/* 企業編號 */
nmafcomp       varchar2(10)      ,/* 法人 */
nmaf001       varchar2(10)      ,/* 交易帳戶編碼 */
nmaf002       varchar2(10)      ,/* 票據類型 */
nmaf003       varchar2(10)      ,/* 套印格式代碼 */
nmaf004       varchar2(10)      ,/* 支票簿號 */
nmaf005       date      ,/* 領用日期 */
nmaf006       varchar2(20)      ,/* 支票起始號碼 */
nmaf007       varchar2(20)      ,/* 支票截止號碼 */
nmaf008       number(5,0)      ,/* 張數 */
nmaf009       number(5,0)      ,/* 流水號長度 */
nmaf010       varchar2(20)      ,/* 下次列印號碼 */
nmaf011       varchar2(1)      ,/* 套印否 */
nmaf012       varchar2(1)      ,/* 領用否 */
nmafownid       varchar2(20)      ,/* 資料所有者 */
nmafowndp       varchar2(10)      ,/* 資料所有部門 */
nmafcrtid       varchar2(20)      ,/* 資料建立者 */
nmafcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmafcrtdt       timestamp(0)      ,/* 資料創建日 */
nmafmodid       varchar2(20)      ,/* 資料修改者 */
nmafmoddt       timestamp(0)      ,/* 最近修改日 */
nmafstus       varchar2(10)      /* 狀態碼 */
);
alter table nmaf_t add constraint nmaf_pk primary key (nmafent,nmaf001,nmaf002,nmaf004) enable validate;

create unique index nmaf_pk on nmaf_t (nmafent,nmaf001,nmaf002,nmaf004);

grant select on nmaf_t to tiptop;
grant update on nmaf_t to tiptop;
grant delete on nmaf_t to tiptop;
grant insert on nmaf_t to tiptop;

exit;
