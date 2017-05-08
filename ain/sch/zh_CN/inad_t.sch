/* 
================================================================================
檔案代號:inad_t
檔案名稱:料件批號資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inad_t
(
inadent       number(5)      ,/* 企業編號 */
inad001       varchar2(40)      ,/* 料件編號 */
inadsite       varchar2(10)      ,/* 營運據點 */
inad002       varchar2(256)      ,/* 產品特徵 */
inad003       varchar2(30)      ,/* 批號 */
inad004       date      ,/* No Use */
inad006       varchar2(20)      ,/* No Use */
inad007       number(10,0)      ,/* No Use */
inad008       number(10,0)      ,/* No Use */
inad009       varchar2(10)      ,/* No Use */
inad010       varchar2(10)      ,/* 供應商編號 */
inad011       date      ,/* 有效日期 */
inad012       varchar2(255)      ,/* 備註 */
inadownid       varchar2(20)      ,/* 資料所有者 */
inadowndp       varchar2(10)      ,/* 資料所屬部門 */
inadcrtid       varchar2(20)      ,/* 資料建立者 */
inadcrtdp       varchar2(10)      ,/* 資料建立部門 */
inadcrtdt       timestamp(0)      ,/* 資料創建日 */
inadmodid       varchar2(20)      ,/* 資料修改者 */
inadmoddt       timestamp(0)      ,/* 最近修改日 */
inadstus       varchar2(10)      ,/* 狀態碼 */
inadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inad_t add constraint inad_pk primary key (inadent,inad001,inadsite,inad002,inad003) enable validate;

create unique index inad_pk on inad_t (inadent,inad001,inadsite,inad002,inad003);

grant select on inad_t to tiptop;
grant update on inad_t to tiptop;
grant delete on inad_t to tiptop;
grant insert on inad_t to tiptop;

exit;
