/* 
================================================================================
檔案代號:prcb_t
檔案名稱:促銷活動計劃申請明細資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prcb_t
(
prcbent       number(5)      ,/* 企業編號 */
prcbunit       varchar2(10)      ,/* 應用組織 */
prcbsite       varchar2(10)      ,/* 營運據點 */
prcbdocno       varchar2(20)      ,/* 單據編號 */
prcbseq       number(10,0)      ,/* 項次 */
prcb001       varchar2(30)      ,/* 活動計劃 */
prcb002       varchar2(10)      ,/* 檔期類型 */
prcb003       varchar2(10)      ,/* 活動等級 */
prcb004       date      ,/* 開始日期 */
prcb005       date      ,/* 結束日期 */
prcb006       varchar2(1)      ,/* 制定促銷方案否 */
prcbacti       varchar2(10)      ,/* 有效否 */
prcbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prcbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prcbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prcbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prcbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prcbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prcbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prcbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prcbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prcbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prcbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prcbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prcbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prcbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prcbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prcbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prcbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prcbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prcbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prcbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prcbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prcbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prcbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prcbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prcbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prcbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prcbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prcbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prcbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prcbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prcb007       number(5,0)      /* 年度 */
);
alter table prcb_t add constraint prcb_pk primary key (prcbent,prcbdocno,prcbseq) enable validate;

create unique index prcb_pk on prcb_t (prcbent,prcbdocno,prcbseq);

grant select on prcb_t to tiptop;
grant update on prcb_t to tiptop;
grant delete on prcb_t to tiptop;
grant insert on prcb_t to tiptop;

exit;
