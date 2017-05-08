/* 
================================================================================
檔案代號:nmac_t
檔案名稱:節假日表資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmac_t
(
nmacent       number(5)      ,/* 企業編號 */
nmacstus       varchar2(10)      ,/* 狀態碼 */
nmac001       varchar2(5)      ,/* 節假日表編號 */
nmac002       date      ,/* 日期 */
nmac003       varchar2(10)      ,/* 節假日類型 */
nmac004       varchar2(80)      ,/* 備註 */
nmac005       number(5,0)      ,/* 年度 */
nmacownid       varchar2(20)      ,/* 資料所有者 */
nmacowndp       varchar2(10)      ,/* 資料所屬部門 */
nmaccrtid       varchar2(20)      ,/* 資料建立者 */
nmaccrtdp       varchar2(10)      ,/* 資料建立部門 */
nmaccrtdt       timestamp(0)      ,/* 資料創建日 */
nmacmodid       varchar2(20)      ,/* 資料修改者 */
nmacmoddt       timestamp(0)      ,/* 最近修改日 */
nmacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmac_t add constraint nmac_pk primary key (nmacent,nmac001,nmac002,nmac005) enable validate;

create unique index nmac_pk on nmac_t (nmacent,nmac001,nmac002,nmac005);

grant select on nmac_t to tiptop;
grant update on nmac_t to tiptop;
grant delete on nmac_t to tiptop;
grant insert on nmac_t to tiptop;

exit;
