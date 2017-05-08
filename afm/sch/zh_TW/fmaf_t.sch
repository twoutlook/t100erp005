/* 
================================================================================
檔案代號:fmaf_t
檔案名稱:融資外幣重評價基礎設置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fmaf_t
(
fmafent       number(5)      ,/* 企業代碼 */
fmafownid       varchar2(20)      ,/*   */
fmafowndp       varchar2(10)      ,/*   */
fmafcrtid       varchar2(20)      ,/*   */
fmafcrtdp       varchar2(10)      ,/*   */
fmafcrtdt       timestamp(0)      ,/*   */
fmafmodid       varchar2(20)      ,/*   */
fmafmoddt       timestamp(0)      ,/* 最近修改日期 */
fmafstus       varchar2(10)      ,/*   */
fmaf001       varchar2(10)      ,/* 法人組織 */
fmaf002       varchar2(5)      ,/* 帳套 */
fmaf003       number(5,0)      ,/* 月底重評價年 */
fmaf004       number(5,0)      ,/* 月底重評價期 */
fmaf005       varchar2(1)      ,/* 月底重評價當月認列匯差，次月不回轉 */
fmaf006       varchar2(1)      ,/* 暫估利息不做月底評價 */
fmaf007       varchar2(1)      ,/* 月底重評價分錄生成方式 */
fmaf008       varchar2(24)      ,/* 匯兌損失科目CR */
fmaf009       varchar2(24)      /* 匯兌收益科目DR */
);
alter table fmaf_t add constraint fmaf_pk primary key (fmafent,fmaf001,fmaf002) enable validate;

create unique index fmaf_pk on fmaf_t (fmafent,fmaf001,fmaf002);

grant select on fmaf_t to tiptop;
grant update on fmaf_t to tiptop;
grant delete on fmaf_t to tiptop;
grant insert on fmaf_t to tiptop;

exit;
