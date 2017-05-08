/* 
================================================================================
檔案代號:prdg_t
檔案名稱:促銷規則申請商品範圍資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdg_t
(
prdgent       number(5)      ,/* 企業編號 */
prdgunit       varchar2(10)      ,/* 應用組織 */
prdgsite       varchar2(10)      ,/* 營運據點 */
prdgdocno       varchar2(20)      ,/* 促銷申請單號 */
prdg001       varchar2(20)      ,/* 規則編號 */
prdg002       number(10,0)      ,/* 組別 */
prdg003       varchar2(10)      ,/* 屬性 */
prdg004       varchar2(40)      ,/* 屬性代碼 */
prdg005       varchar2(40)      ,/* 商品條碼 */
prdg006       varchar2(10)      ,/* 單位 */
prdg007       number(20,6)      ,/* 成本價 */
prdg008       number(20,6)      ,/* 目標數量 */
prdg009       number(20,6)      ,/* 目標金額 */
prdg010       number(10,0)      ,/* 條件組別 */
prdgacti       varchar2(10)      ,/* 有效否 */
prdgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdgud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prdg011       varchar2(10)      ,/* 方向 */
prdg012       varchar2(10)      /* 庫區編號 */
);
alter table prdg_t add constraint prdg_pk primary key (prdgent,prdgdocno,prdg002,prdg003,prdg004) enable validate;

create unique index prdg_pk on prdg_t (prdgent,prdgdocno,prdg002,prdg003,prdg004);

grant select on prdg_t to tiptop;
grant update on prdg_t to tiptop;
grant delete on prdg_t to tiptop;
grant insert on prdg_t to tiptop;

exit;
