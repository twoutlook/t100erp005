/* 
================================================================================
檔案代號:fmaj_t
檔案名稱:融資合同檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fmaj_t
(
fmajent       number(5)      ,/* 企業編號 */
fmaj001       varchar2(10)      ,/* 融資合同編號 */
fmaj002       varchar2(10)      ,/* 融資組織 */
fmaj003       varchar2(10)      ,/* 融資類型 */
fmaj004       varchar2(10)      ,/* 融資申請確認單號 */
fmaj005       varchar2(20)      ,/* 銀行貸款合同編號 */
fmaj006       varchar2(15)      ,/* 貸款銀行 */
fmaj007       varchar2(20)      ,/* 合約編號 */
fmaj008       date      ,/* 簽訂日期 */
fmaj009       date      ,/* 貸款期限起 */
fmaj010       date      ,/* 貸款期限止 */
fmaj011       number(5,0)      ,/* 計息基礎 */
fmaj012       varchar2(1)      ,/* 不定日分次劃付 */
fmaj013       varchar2(1)      ,/* 擔保方式 */
fmaj014       varchar2(20)      ,/* 保證人 */
fmaj015       varchar2(40)      ,/* 保證合同號 */
fmaj016       varchar2(10)      ,/* 抵押人 */
fmaj017       varchar2(40)      ,/* 抵押合同號 */
fmaj018       varchar2(10)      ,/* 質押人 */
fmaj019       varchar2(40)      ,/* 質押合同號 */
fmaj020       number(10,0)      ,/* 融資申請確認項次 */
fmajownid       varchar2(20)      ,/* 資料所有者 */
fmajowndp       varchar2(10)      ,/* 資料所屬部門 */
fmajcrtid       varchar2(20)      ,/* 資料建立者 */
fmajcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmajcrtdt       timestamp(0)      ,/* 資料創建日 */
fmajmodid       varchar2(20)      ,/* 資料修改者 */
fmajmoddt       timestamp(0)      ,/* 最近修改日 */
fmajcnfid       varchar2(20)      ,/* 資料確認者 */
fmajcnfdt       timestamp(0)      ,/* 資料確認日 */
fmajstus       varchar2(10)      /* 狀態碼 */
);
alter table fmaj_t add constraint fmaj_pk primary key (fmajent,fmaj001) enable validate;

create unique index fmaj_pk on fmaj_t (fmajent,fmaj001);

grant select on fmaj_t to tiptop;
grant update on fmaj_t to tiptop;
grant delete on fmaj_t to tiptop;
grant insert on fmaj_t to tiptop;

exit;
