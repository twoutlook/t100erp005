/* 
================================================================================
檔案代號:rtdm_t
檔案名稱:商品組成用量單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table rtdm_t
(
rtdment       number(5)      ,/* 企業編號 */
rtdmunit       varchar2(10)      ,/* 應用組織 */
rtdm001       varchar2(40)      ,/* 主商品編號 */
rtdm002       varchar2(10)      ,/* 版本 */
rtdm003       varchar2(40)      ,/* 商品條碼 */
rtdm004       varchar2(10)      ,/* 單位 */
rtdmstus       varchar2(10)      ,/* 狀態碼 */
rtdmownid       varchar2(20)      ,/* 資料所有者 */
rtdmowndp       varchar2(10)      ,/* 資料所屬部門 */
rtdmcrtid       varchar2(20)      ,/* 資料建立者 */
rtdmcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtdmcrtdt       timestamp(0)      ,/* 資料創建日 */
rtdmmodid       varchar2(20)      ,/* 資料修改者 */
rtdmmoddt       timestamp(0)      ,/* 最近修改日 */
rtdmcnfid       varchar2(20)      ,/* 資料確認者 */
rtdmcnfdt       timestamp(0)      ,/* 資料確認日 */
rtdmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtdm_t add constraint rtdm_pk primary key (rtdment,rtdm001) enable validate;

create unique index rtdm_pk on rtdm_t (rtdment,rtdm001);

grant select on rtdm_t to tiptop;
grant update on rtdm_t to tiptop;
grant delete on rtdm_t to tiptop;
grant insert on rtdm_t to tiptop;

exit;
