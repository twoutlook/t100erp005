/* 
================================================================================
檔案代號:prdk_t
檔案名稱:促銷規則申請換贈商品資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdk_t
(
prdkent       number(5)      ,/* 企業編號 */
prdkunit       varchar2(10)      ,/* 應用組織 */
prdksite       varchar2(10)      ,/* 營運據點 */
prdkdocno       varchar2(20)      ,/* 促銷申請單號 */
prdk001       varchar2(20)      ,/* 規則編號 */
prdk002       number(10,0)      ,/* 換贈組別 */
prdk003       number(10,0)      ,/* 換贈商品組別 */
prdk004       varchar2(10)      ,/* 屬性 */
prdk005       varchar2(40)      ,/* 屬性編號 */
prdk006       varchar2(40)      ,/* 商品條碼 */
prdk007       varchar2(10)      ,/* 單位 */
prdk008       number(20,6)      ,/* 成本價 */
prdk009       number(20,6)      ,/* 儲值金額/比例 */
prdk010       varchar2(10)      ,/* 有效期至 */
prdk011       date      ,/* 指定日期 */
prdk012       number(5,0)      ,/* 指定長度 */
prdkacti       varchar2(10)      ,/* 有效否 */
prdkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdkud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prdk013       varchar2(10)      /* 儲值類型 */
);
alter table prdk_t add constraint prdk_pk primary key (prdkent,prdkdocno,prdk002,prdk003,prdk004,prdk005) enable validate;

create unique index prdk_pk on prdk_t (prdkent,prdkdocno,prdk002,prdk003,prdk004,prdk005);

grant select on prdk_t to tiptop;
grant update on prdk_t to tiptop;
grant delete on prdk_t to tiptop;
grant insert on prdk_t to tiptop;

exit;
