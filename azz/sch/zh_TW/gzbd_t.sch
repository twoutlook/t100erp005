/* 
================================================================================
檔案代號:gzbd_t
檔案名稱:系統流程中可使用的節點
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzbd_t
(
gzbd001       varchar2(40)      ,/* 節點代號 */
gzbd002       varchar2(10)      ,/* 節點類型 */
gzbd003       varchar2(40)      ,/* 節點圖片 */
gzbdent       number(5)      ,/* 企業代碼 */
gzbdownid       varchar2(20)      ,/* 資料所有者 */
gzbdowndp       varchar2(10)      ,/* 資料所屬部門 */
gzbdcrtid       varchar2(20)      ,/* 資料建立者 */
gzbdcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzbdcrtdt       timestamp(0)      ,/* 資料創建日 */
gzbdmodid       varchar2(20)      ,/* 資料修改者 */
gzbdmoddt       timestamp(0)      ,/* 最近修改日 */
gzbdstus       varchar2(10)      ,/* 狀態碼 */
gzbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzbd_t add constraint gzbd_pk primary key (gzbd001,gzbdent) enable validate;

create unique index gzbd_pk on gzbd_t (gzbd001,gzbdent);

grant select on gzbd_t to tiptop;
grant update on gzbd_t to tiptop;
grant delete on gzbd_t to tiptop;
grant insert on gzbd_t to tiptop;

exit;
