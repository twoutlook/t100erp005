/* 
================================================================================
檔案代號:fmab_t
檔案名稱:融資科目設置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fmab_t
(
fmabent       number(5)      ,/* 企業編號 */
fmab001       varchar2(10)      ,/* 融資類型 */
fmab002       varchar2(5)      ,/* 會計科目參照表號 */
fmab003       varchar2(24)      ,/* 融資本金面值科目 */
fmab004       varchar2(24)      ,/* 利息調整科目 */
fmab005       varchar2(24)      ,/* 保證費用科目 */
fmab006       varchar2(24)      ,/* 承銷費用科目 */
fmab007       varchar2(24)      ,/* 簽證費用科目 */
fmab008       varchar2(24)      ,/* 交割服務費用科目 */
fmab009       varchar2(24)      ,/* 費用化利息科目 */
fmab010       varchar2(24)      ,/* 應付利息科目 */
fmab011       varchar2(24)      ,/* LC折價科目 */
fmabownid       varchar2(20)      ,/* 資料所有者 */
fmabowndp       varchar2(10)      ,/* 資料所屬部門 */
fmabcrtid       varchar2(20)      ,/* 資料建立者 */
fmabcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmabcrtdt       timestamp(0)      ,/* 資料創建日 */
fmabmodid       varchar2(20)      ,/* 資料修改者 */
fmabmoddt       timestamp(0)      ,/* 最近修改日 */
fmabstus       varchar2(10)      /* 狀態碼 */
);
alter table fmab_t add constraint fmab_pk primary key (fmabent,fmab001,fmab002) enable validate;

create unique index fmab_pk on fmab_t (fmabent,fmab001,fmab002);

grant select on fmab_t to tiptop;
grant update on fmab_t to tiptop;
grant delete on fmab_t to tiptop;
grant insert on fmab_t to tiptop;

exit;
