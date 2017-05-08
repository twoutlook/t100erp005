/* 
================================================================================
檔案代號:apdg_t
檔案名稱:付款資料變更明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table apdg_t
(
apdgent       number(5)      ,/* 企業編號 */
apdgdocno       varchar2(20)      ,/* 申請單號 */
apdgld       varchar2(5)      ,/* 帳套 */
apdgcomp       varchar2(10)      ,/* 公司別 */
apdgsite       varchar2(10)      ,/* 帳務中心 */
apdgseq       number(10,0)      ,/* 項次 */
apdg001       varchar2(20)      ,/* 付款單號 */
apdg002       number(10,0)      ,/* 付款項次 */
apdg003       varchar2(10)      ,/* 付款對象 */
apdg004       varchar2(255)      ,/* 原受款人全名 */
apdg005       varchar2(15)      ,/* 原受款銀行 */
apdg006       varchar2(30)      ,/* 原受款人帳號 */
apdg007       date      ,/* 原付款日期 */
apdg010       varchar2(255)      ,/* 變更原因 */
apdg014       varchar2(255)      ,/* 變更受款人全名 */
apdg015       varchar2(15)      ,/* 變更受款銀行 */
apdg016       varchar2(30)      ,/* 變更受款人帳號 */
apdg017       date      ,/* 變更付款日期 */
apdgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apdgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apdgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apdgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apdgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apdgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apdgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apdgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apdgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apdgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apdgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apdgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apdgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apdgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apdgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apdgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apdgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apdgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apdgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apdgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apdgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apdgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apdgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apdgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apdgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apdgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apdgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apdgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apdgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apdgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apdg_t add constraint apdg_pk primary key (apdgent,apdgdocno,apdgld,apdgseq) enable validate;

create unique index apdg_pk on apdg_t (apdgent,apdgdocno,apdgld,apdgseq);

grant select on apdg_t to tiptop;
grant update on apdg_t to tiptop;
grant delete on apdg_t to tiptop;
grant insert on apdg_t to tiptop;

exit;
