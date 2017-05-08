/* 
================================================================================
檔案代號:pmcm_t
檔案名稱:供應商評核綜合得分調整明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmcm_t
(
pmcment       number(5)      ,/* 企業編號 */
pmcmdocno       varchar2(20)      ,/* 單據編號 */
pmcmseq       number(10,0)      ,/* 項次 */
pmcm001       varchar2(10)      ,/* 供應商編號 */
pmcm002       varchar2(10)      ,/* 評核期別 */
pmcm003       varchar2(10)      ,/* 評核品類 */
pmcm004       number(15,3)      ,/* 系統得分 */
pmcm005       number(15,3)      ,/* 調整前得分 */
pmcm006       number(15,3)      ,/* 調整後得分 */
pmcm007       number(5,0)      ,/* 調整次數 */
pmcm008       varchar2(10)      ,/* 調整後等級 */
pmcm009       varchar2(10)      ,/* 處理建議 */
pmcmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmcmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmcmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmcmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmcmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmcmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmcmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmcmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmcmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmcmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmcmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmcmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmcmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmcmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmcmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmcmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmcmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmcmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmcmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmcmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmcmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmcmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmcmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmcmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmcmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmcmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmcmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmcmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmcmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmcmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmcm_t add constraint pmcm_pk primary key (pmcment,pmcmdocno,pmcmseq) enable validate;

create unique index pmcm_pk on pmcm_t (pmcment,pmcmdocno,pmcmseq);

grant select on pmcm_t to tiptop;
grant update on pmcm_t to tiptop;
grant delete on pmcm_t to tiptop;
grant insert on pmcm_t to tiptop;

exit;
