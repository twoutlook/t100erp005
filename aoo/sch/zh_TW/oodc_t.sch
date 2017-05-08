/* 
================================================================================
檔案代號:oodc_t
檔案名稱:複合稅資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oodc_t
(
oodcent       number(5)      ,/* 企業編號 */
oodcownid       varchar2(20)      ,/* 資料所有者 */
oodcowndp       varchar2(10)      ,/* 資料所屬部門 */
oodccrtid       varchar2(20)      ,/* 資料建立者 */
oodccrtdp       varchar2(10)      ,/* 資料建立部門 */
oodccrtdt       timestamp(0)      ,/* 資料創建日 */
oodcmodid       varchar2(20)      ,/* 資料修改者 */
oodcmoddt       timestamp(0)      ,/* 最近修改日 */
oodcstus       varchar2(10)      ,/* 狀態碼 */
oodc001       varchar2(10)      ,/* 交易稅區 */
oodc002       varchar2(10)      ,/* 複合稅代碼 */
oodc003       varchar2(10)      ,/* 稅別代碼 */
oodcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oodcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oodcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oodcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oodcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oodcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oodcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oodcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oodcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oodcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oodcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oodcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oodcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oodcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oodcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oodcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oodcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oodcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oodcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oodcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oodcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oodcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oodcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oodcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oodcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oodcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oodcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oodcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oodcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oodcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oodc_t add constraint oodc_pk primary key (oodcent,oodc001,oodc002,oodc003) enable validate;

create unique index oodc_pk on oodc_t (oodcent,oodc001,oodc002,oodc003);

grant select on oodc_t to tiptop;
grant update on oodc_t to tiptop;
grant delete on oodc_t to tiptop;
grant insert on oodc_t to tiptop;

exit;
