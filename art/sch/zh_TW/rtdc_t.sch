/* 
================================================================================
檔案代號:rtdc_t
檔案名稱:生命週期限定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtdc_t
(
rtdcent       number(5)      ,/* 企業編號 */
rtdc001       varchar2(20)      ,/* 程序編號 */
rtdc002       varchar2(10)      ,/* 生命週期類型 */
rtdc003       varchar2(10)      ,/* 生命週期編號 */
rtdcstus       varchar2(10)      ,/* 狀態 */
rtdcownid       varchar2(20)      ,/* 資料所有者 */
rtdcowndp       varchar2(10)      ,/* 資料所屬部門 */
rtdccrtid       varchar2(20)      ,/* 資料建立者 */
rtdccrtdp       varchar2(10)      ,/* 資料建立部門 */
rtdccrtdt       timestamp(0)      ,/* 資料創建日 */
rtdcmodid       varchar2(20)      ,/* 資料修改者 */
rtdcmoddt       timestamp(0)      ,/* 最近修改日 */
rtdcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtdc_t add constraint rtdc_pk primary key (rtdcent,rtdc001,rtdc002,rtdc003) enable validate;

create unique index rtdc_pk on rtdc_t (rtdcent,rtdc001,rtdc002,rtdc003);

grant select on rtdc_t to tiptop;
grant update on rtdc_t to tiptop;
grant delete on rtdc_t to tiptop;
grant insert on rtdc_t to tiptop;

exit;
