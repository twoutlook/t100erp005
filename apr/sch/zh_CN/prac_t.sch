/* 
================================================================================
檔案代號:prac_t
檔案名稱:取價策略資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table prac_t
(
pracent       number(5)      ,/* 企業編號 */
prac001       varchar2(10)      ,/* 價格編號 */
prac002       varchar2(10)      ,/* 疊加方式 */
prac003       varchar2(1)      ,/* 未取到價格可人工輸入 */
prac004       varchar2(1)      ,/* 價格允許修改 */
pracstus       varchar2(10)      ,/* 狀態碼 */
pracownid       varchar2(20)      ,/* 資料所有者 */
pracowndp       varchar2(10)      ,/* 資料所屬部門 */
praccrtid       varchar2(20)      ,/* 資料建立者 */
praccrtdp       varchar2(10)      ,/* 資料建立部門 */
praccrtdt       timestamp(0)      ,/* 資料創建日 */
pracmodid       varchar2(20)      ,/* 資料修改者 */
pracmoddt       timestamp(0)      ,/* 最近修改日 */
pracud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pracud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pracud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pracud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pracud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pracud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pracud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pracud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pracud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pracud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pracud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pracud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pracud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pracud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pracud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pracud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pracud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pracud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pracud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pracud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pracud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pracud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pracud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pracud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pracud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pracud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pracud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pracud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pracud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pracud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prac_t add constraint prac_pk primary key (pracent,prac001) enable validate;

create unique index prac_pk on prac_t (pracent,prac001);

grant select on prac_t to tiptop;
grant update on prac_t to tiptop;
grant delete on prac_t to tiptop;
grant insert on prac_t to tiptop;

exit;
