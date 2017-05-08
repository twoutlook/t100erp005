/* 
================================================================================
檔案代號:rtay_t
檔案名稱:部門品類分配設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtay_t
(
rtayent       number(5)      ,/* 企業代碼 */
rtay001       varchar2(10)      ,/* 部門編號 */
rtay002       varchar2(10)      ,/* 品類編號 */
rtayownid       varchar2(20)      ,/* 資料所有者 */
rtayowndp       varchar2(10)      ,/* 資料所屬部門 */
rtaycrtid       varchar2(20)      ,/* 資料建立者 */
rtaycrtdp       varchar2(10)      ,/* 資料建立部門 */
rtaycrtdt       timestamp(0)      ,/* 資料創建日 */
rtaymodid       varchar2(20)      ,/* 資料修改者 */
rtaymoddt       timestamp(0)      ,/* 最近修改日 */
rtaystus       varchar2(10)      ,/* 狀態碼 */
rtayud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtayud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtayud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtayud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtayud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtayud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtayud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtayud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtayud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtayud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtayud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtayud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtayud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtayud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtayud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtayud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtayud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtayud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtayud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtayud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtayud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtayud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtayud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtayud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtayud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtayud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtayud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtayud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtayud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtayud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtay_t add constraint rtay_pk primary key (rtayent,rtay001,rtay002) enable validate;

create unique index rtay_pk on rtay_t (rtayent,rtay001,rtay002);

grant select on rtay_t to tiptop;
grant update on rtay_t to tiptop;
grant delete on rtay_t to tiptop;
grant insert on rtay_t to tiptop;

exit;
