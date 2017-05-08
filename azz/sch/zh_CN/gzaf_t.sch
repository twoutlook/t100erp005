/* 
================================================================================
檔案代號:gzaf_t
檔案名稱:參數規劃檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzaf_t
(
gzaf001       varchar2(10)      ,/* 參數層級 */
gzaf002       number(10,0)      ,/* 序號 */
gzaf003       varchar2(10)      ,/* 大模組 */
gzaf004       varchar2(80)      ,/* 運用模組 */
gzaf005       varchar2(80)      ,/* 應用類型 */
gzaf006       varchar2(500)      ,/* 參數說明 */
gzaf007       varchar2(80)      ,/* 預設值 */
gzaf008       varchar2(80)      ,/* 輸入範圍 */
gzaf009       varchar2(500)      ,/* 備註 */
gzaf010       varchar2(500)      ,/* 應用建議 */
gzafstus       varchar2(10)      ,/* 狀態碼 */
gzafownid       varchar2(20)      ,/* 資料所有者 */
gzafowndp       varchar2(10)      ,/* 資料所屬部門 */
gzafcrtid       varchar2(20)      ,/* 資料建立者 */
gzafcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzafcrtdt       timestamp(0)      ,/* 資料創建日 */
gzafmodid       varchar2(20)      ,/* 資料修改者 */
gzafmoddt       timestamp(0)      ,/* 最近修改日 */
gzafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzaf_t add constraint gzaf_pk primary key (gzaf001,gzaf002) enable validate;

create unique index gzaf_pk on gzaf_t (gzaf001,gzaf002);

grant select on gzaf_t to tiptop;
grant update on gzaf_t to tiptop;
grant delete on gzaf_t to tiptop;
grant insert on gzaf_t to tiptop;

exit;
