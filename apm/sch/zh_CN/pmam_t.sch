/* 
================================================================================
檔案代號:pmam_t
檔案名稱:採購取價方式單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmam_t
(
pmament       number(5)      ,/* 企業編號 */
pmamownid       varchar2(20)      ,/* 資料所有者 */
pmamowndp       varchar2(10)      ,/* 資料所屬部門 */
pmamcrtid       varchar2(20)      ,/* 資料建立者 */
pmamcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmamcrtdt       timestamp(0)      ,/* 資料創建日 */
pmammodid       varchar2(20)      ,/* 資料修改者 */
pmammoddt       timestamp(0)      ,/* 最近修改日 */
pmamstus       varchar2(10)      ,/* 狀態碼 */
pmam001       varchar2(10)      ,/* 取價方式編號 */
pmam002       varchar2(1)      ,/* 未取到價格允許人工輸入 */
pmam003       varchar2(1)      ,/* 價格允許修改 */
pmam004       number(20,6)      ,/* 修改容差率 */
pmam005       varchar2(10)      ,/* 價格超過容差率的處理方式 */
pmam006       varchar2(1)      ,/* 允許單價為0 */
pmamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmamud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmam_t add constraint pmam_pk primary key (pmament,pmam001) enable validate;

create unique index pmam_pk on pmam_t (pmament,pmam001);

grant select on pmam_t to tiptop;
grant update on pmam_t to tiptop;
grant delete on pmam_t to tiptop;
grant insert on pmam_t to tiptop;

exit;
