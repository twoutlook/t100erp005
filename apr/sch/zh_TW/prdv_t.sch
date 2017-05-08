/* 
================================================================================
檔案代號:prdv_t
檔案名稱:促銷規則換贈商品資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdv_t
(
prdvent       number(5)      ,/* 企業編號 */
prdvunit       varchar2(10)      ,/* 應用組織 */
prdvsite       varchar2(10)      ,/* 營運據點 */
prdv001       varchar2(20)      ,/* 規則編號 */
prdv002       number(10,0)      ,/* 換贈組別 */
prdv003       number(10,0)      ,/* 換贈商品組別 */
prdv004       varchar2(10)      ,/* 屬性 */
prdv005       varchar2(40)      ,/* 屬性編號 */
prdv006       varchar2(40)      ,/* 商品條碼 */
prdv007       varchar2(10)      ,/* 單位 */
prdv008       number(20,6)      ,/* 成本價 */
prdv009       number(20,6)      ,/* 儲值金額/比例 */
prdv010       varchar2(10)      ,/* 有效期至 */
prdv011       date      ,/* 指定日期 */
prdv012       number(5,0)      ,/* 指定長度 */
prdvstus       varchar2(10)      ,/* 有效否 */
prdvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdvud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prdv013       varchar2(10)      /* 儲值類型 */
);
alter table prdv_t add constraint prdv_pk primary key (prdvent,prdv001,prdv002,prdv003,prdv004,prdv005) enable validate;

create unique index prdv_pk on prdv_t (prdvent,prdv001,prdv002,prdv003,prdv004,prdv005);

grant select on prdv_t to tiptop;
grant update on prdv_t to tiptop;
grant delete on prdv_t to tiptop;
grant insert on prdv_t to tiptop;

exit;
