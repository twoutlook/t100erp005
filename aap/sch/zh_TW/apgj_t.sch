/* 
================================================================================
檔案代號:apgj_t
檔案名稱:裝船通知單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apgj_t
(
apgjent       number(5)      ,/* 企業編號 */
apgjcomp       varchar2(10)      ,/* 法人 */
apgjdocno       varchar2(20)      ,/* 通知單號 */
apgjseq       number(10,0)      ,/* 項次 */
apgjseq2       number(10,0)      ,/* 申請單項次 */
apgjorga       varchar2(10)      ,/* 來源組織 */
apgj001       varchar2(20)      ,/* 採購單號 */
apgj002       number(10,0)      ,/* 採購單號項次 */
apgj003       varchar2(40)      ,/* 產品編號 */
apgj004       number(20,6)      ,/* 原幣單價 */
apgj005       number(20,6)      ,/* 裝船數量 */
apgj103       number(20,6)      ,/* 原幣金額 */
apgjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apgjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apgjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apgjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apgjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apgjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apgjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apgjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apgjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apgjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apgjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apgjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apgjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apgjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apgjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apgjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apgjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apgjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apgjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apgjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apgjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apgjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apgjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apgjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apgjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apgjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apgjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apgjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apgjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apgjud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apgj100       varchar2(10)      ,/* 幣別 */
apgj101       number(20,10)      /* 匯率 */
);
alter table apgj_t add constraint apgj_pk primary key (apgjent,apgjcomp,apgjdocno,apgjseq) enable validate;

create unique index apgj_pk on apgj_t (apgjent,apgjcomp,apgjdocno,apgjseq);

grant select on apgj_t to tiptop;
grant update on apgj_t to tiptop;
grant delete on apgj_t to tiptop;
grant insert on apgj_t to tiptop;

exit;
