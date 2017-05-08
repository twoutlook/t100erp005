/* 
================================================================================
檔案代號:pmcb_t
檔案名稱:供應商證照異動單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmcb_t
(
pmcbent       number(5)      ,/* 企業編號 */
pmcbdocno       varchar2(20)      ,/* 單據編號 */
pmcbseq       number(10,0)      ,/* 項次 */
pmcb001       varchar2(10)      ,/* 供應商編號 */
pmcb002       varchar2(10)      ,/* 證照類別 */
pmcb003       varchar2(40)      ,/* 證照號碼 */
pmcb004       varchar2(80)      ,/* 證照名稱 */
pmcb005       varchar2(10)      ,/* 經營品類 */
pmcb006       varchar2(40)      ,/* 商品編號 */
pmcb007       date      ,/* 生效日期 */
pmcb008       date      ,/* 失效日期 */
pmcb009       varchar2(10)      ,/* 證照提供組織 */
pmcbacti       varchar2(1)      ,/* 證照有效 */
pmcbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmcbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmcbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmcbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmcbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmcbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmcbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmcbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmcbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmcbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmcbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmcbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmcbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmcbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmcbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmcbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmcbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmcbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmcbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmcbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmcbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmcbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmcbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmcbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmcbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmcbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmcbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmcbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmcbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmcbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmcb010       varchar2(10)      ,/* 原證照類別 */
pmcb011       varchar2(40)      /* 原證照號碼 */
);
alter table pmcb_t add constraint pmcb_pk primary key (pmcbent,pmcbdocno,pmcbseq) enable validate;

create unique index pmcb_pk on pmcb_t (pmcbent,pmcbdocno,pmcbseq);

grant select on pmcb_t to tiptop;
grant update on pmcb_t to tiptop;
grant delete on pmcb_t to tiptop;
grant insert on pmcb_t to tiptop;

exit;
