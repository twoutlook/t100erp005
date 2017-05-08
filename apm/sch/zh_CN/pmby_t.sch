/* 
================================================================================
檔案代號:pmby_t
檔案名稱:交易對象准入-經銷商市場能力
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmby_t
(
pmbyent       number(5)      ,/* 企業編號 */
pmbydocno       varchar2(20)      ,/* 單據編號 */
pmby001       varchar2(10)      ,/* 交易對象編號 */
pmby002       varchar2(10)      ,/* 終端渠道類別 */
pmby003       varchar2(10)      ,/* 終端渠道編號 */
pmby004       number(10,0)      ,/* 渠道崗位經理人數 */
pmby005       number(10,0)      ,/* 覆蓋終端店數 */
pmbyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbyud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmby_t add constraint pmby_pk primary key (pmbyent,pmbydocno,pmby002,pmby003) enable validate;

create unique index pmby_pk on pmby_t (pmbyent,pmbydocno,pmby002,pmby003);

grant select on pmby_t to tiptop;
grant update on pmby_t to tiptop;
grant delete on pmby_t to tiptop;
grant insert on pmby_t to tiptop;

exit;
