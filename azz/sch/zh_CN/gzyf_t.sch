/* 
================================================================================
檔案代號:gzyf_t
檔案名稱:畫面欄位隱藏設定紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzyf_t
(
gzyfent       number(5)      ,/* 企業代碼 */
gzyfownid       varchar2(20)      ,/* 資料所有者 */
gzyfowndp       varchar2(10)      ,/* 資料所屬部門 */
gzyfcrtid       varchar2(20)      ,/* 資料建立者 */
gzyfcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzyfcrtdt       timestamp(0)      ,/* 資料創建日 */
gzyfmodid       varchar2(20)      ,/* 資料修改者 */
gzyfmoddt       timestamp(0)      ,/* 最近修改日 */
gzyfstus       varchar2(10)      ,/* 狀態碼 */
gzyf001       varchar2(20)      ,/* 規格(畫面)編號 */
gzyf002       varchar2(20)      ,/* 元件(欄位)編號 */
gzyf003       varchar2(80)      ,/* 欄位隱藏設定 */
gzyf004       varchar2(20)      ,/* 指定頁簽 */
gzyfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzyfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzyfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzyfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzyfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzyfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzyfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzyfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzyfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzyfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzyfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzyfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzyfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzyfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzyfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzyfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzyfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzyfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzyfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzyfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzyfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzyfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzyfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzyfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzyfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzyfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzyfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzyfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzyfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzyfud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzyf005       varchar2(1)      /* 元件隱藏 */
);
alter table gzyf_t add constraint gzyf_pk primary key (gzyfent,gzyf001,gzyf002) enable validate;

create unique index gzyf_pk on gzyf_t (gzyfent,gzyf001,gzyf002);

grant select on gzyf_t to tiptop;
grant update on gzyf_t to tiptop;
grant delete on gzyf_t to tiptop;
grant insert on gzyf_t to tiptop;

exit;
