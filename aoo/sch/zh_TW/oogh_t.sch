/* 
================================================================================
檔案代號:oogh_t
檔案名稱:員工投入工時檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oogh_t
(
ooghent       number(5)      ,/* 企業編號 */
ooghstus       varchar2(10)      ,/* 狀態碼 */
oogh001       varchar2(10)      ,/* 組別編號 */
oogh002       varchar2(20)      ,/* 員工編號 */
oogh003       date      ,/* 日期 */
oogh004       number(15,3)      ,/* 應投入工時 */
oogh005       number(15,3)      ,/* 休假扣減 */
oogh006       number(15,3)      ,/* 加班工時 */
oogh007       number(15,3)      ,/* 實際投入工時 */
oogh008       number(15,3)      ,/* 例外工時 */
oogh009       number(15,3)      ,/* 約當工時 */
ooghsite       varchar2(10)      ,/* 營運據點 */
ooghownid       varchar2(20)      ,/* 資料所有者 */
ooghowndp       varchar2(10)      ,/* 資料所屬部門 */
ooghcrtid       varchar2(20)      ,/* 資料建立者 */
ooghcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooghcrtdt       timestamp(0)      ,/* 資料創建日 */
ooghmodid       varchar2(20)      ,/* 資料修改者 */
ooghmoddt       timestamp(0)      ,/* 最近修改日 */
ooghud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooghud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooghud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooghud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooghud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooghud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooghud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooghud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooghud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooghud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooghud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooghud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooghud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooghud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooghud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooghud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooghud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooghud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooghud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooghud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooghud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooghud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooghud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooghud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooghud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooghud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooghud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooghud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooghud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooghud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oogh_t add constraint oogh_pk primary key (ooghent,oogh001,oogh002,oogh003,ooghsite) enable validate;

create unique index oogh_pk on oogh_t (ooghent,oogh001,oogh002,oogh003,ooghsite);

grant select on oogh_t to tiptop;
grant update on oogh_t to tiptop;
grant delete on oogh_t to tiptop;
grant insert on oogh_t to tiptop;

exit;
