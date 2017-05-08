/* 
================================================================================
檔案代號:gzba_t
檔案名稱:系統流程圖選單分類檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table gzba_t
(
gzba001       varchar2(40)      ,/* 分類代號 */
gzba002       varchar2(40)      ,/* 上層分類代號 */
gzba003       number(5,0)      ,/* 順序 */
gzbaent       number(5)      ,/* 企業代碼 */
gzbaownid       varchar2(20)      ,/* 資料所有者 */
gzbaowndp       varchar2(10)      ,/* 資料所屬部門 */
gzbacrtid       varchar2(20)      ,/* 資料建立者 */
gzbacrtdp       varchar2(10)      ,/* 資料建立部門 */
gzbacrtdt       timestamp(0)      ,/* 資料創建日 */
gzbamodid       varchar2(20)      ,/* 資料修改者 */
gzbamoddt       timestamp(0)      ,/* 最近修改日 */
gzbastus       varchar2(10)      ,/* 狀態碼 */
gzbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzbaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzba_t add constraint gzba_pk primary key (gzba001,gzbaent) enable validate;

create unique index gzba_pk on gzba_t (gzba001,gzbaent);

grant select on gzba_t to tiptop;
grant update on gzba_t to tiptop;
grant delete on gzba_t to tiptop;
grant insert on gzba_t to tiptop;

exit;
