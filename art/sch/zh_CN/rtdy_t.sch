/* 
================================================================================
檔案代號:rtdy_t
檔案名稱:標價籤模板資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtdy_t
(
rtdyent       number(5)      ,/* 企業編號 */
rtdy001       varchar2(10)      ,/* 模板編號 */
rtdy002       varchar2(255)      ,/* 存放路徑 */
rtdy003       varchar2(15)      ,/* 文件名 */
rtdystus       varchar2(10)      ,/* 狀態碼 */
rtdyownid       varchar2(20)      ,/* 資料所有者 */
rtdyowndp       varchar2(10)      ,/* 資料所屬部門 */
rtdycrtid       varchar2(20)      ,/* 資料建立者 */
rtdycrtdp       varchar2(10)      ,/* 資料建立部門 */
rtdycrtdt       timestamp(0)      ,/* 資料創建日 */
rtdymodid       varchar2(20)      ,/* 資料修改者 */
rtdymoddt       timestamp(0)      ,/* 最近修改日 */
rtdyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdyud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtdy_t add constraint rtdy_pk primary key (rtdyent,rtdy001) enable validate;

create unique index rtdy_pk on rtdy_t (rtdyent,rtdy001);

grant select on rtdy_t to tiptop;
grant update on rtdy_t to tiptop;
grant delete on rtdy_t to tiptop;
grant insert on rtdy_t to tiptop;

exit;
