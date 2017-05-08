/* 
================================================================================
檔案代號:gzwm_t
檔案名稱:公式/運算/條件資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzwm_t
(
gzwm001       varchar2(40)      ,/* 運算代碼 */
gzwm002       varchar2(1)      ,/* 運算類型 */
gzwm003       varchar2(10)      ,/* 欄位屬性 */
gzwm004       varchar2(10)      ,/* 引導輸入框 */
gzwm005       varchar2(2)      ,/* 運算元對應代碼 */
gzwm006       varchar2(1)      ,/* 進階設定使用 */
gzwm007       number(5,0)      ,/* 顯示順序 */
gzwmownid       varchar2(20)      ,/* 資料所有者 */
gzwmowndp       varchar2(10)      ,/* 資料所屬部門 */
gzwmcrtid       varchar2(20)      ,/* 資料建立者 */
gzwmcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzwmcrtdt       timestamp(0)      ,/* 資料創建日 */
gzwmmodid       varchar2(20)      ,/* 資料修改者 */
gzwmmoddt       timestamp(0)      ,/* 最近修改日 */
gzwmstus       varchar2(10)      ,/* 狀態碼 */
gzwm008       varchar2(500)      ,/* 固定公式 */
gzwm009       varchar2(1)      ,/* 允許條件值輸入 */
gzwmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzwmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzwmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzwmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzwmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzwmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzwmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzwmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzwmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzwmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzwmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzwmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzwmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzwmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzwmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzwmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzwmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzwmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzwmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzwmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzwmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzwmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzwmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzwmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzwmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzwmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzwmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzwmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzwmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzwmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzwm_t add constraint gzwm_pk primary key (gzwm001,gzwm002,gzwm003) enable validate;

create unique index gzwm_pk on gzwm_t (gzwm001,gzwm002,gzwm003);

grant select on gzwm_t to tiptop;
grant update on gzwm_t to tiptop;
grant delete on gzwm_t to tiptop;
grant insert on gzwm_t to tiptop;

exit;
