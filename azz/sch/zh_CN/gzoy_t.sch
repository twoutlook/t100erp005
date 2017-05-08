/* 
================================================================================
檔案代號:gzoy_t
檔案名稱:多語言用詞調整紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gzoy_t
(
gzoyownid       varchar2(20)      ,/* 資料所有者 */
gzoyowndp       varchar2(10)      ,/* 資料所屬部門 */
gzoycrtid       varchar2(20)      ,/* 資料建立者 */
gzoycrtdp       varchar2(10)      ,/* 資料建立部門 */
gzoycrtdt       timestamp(0)      ,/* 資料創建日 */
gzoymodid       varchar2(20)      ,/* 資料修改者 */
gzoymoddt       timestamp(0)      ,/* 最近修改日 */
gzoystus       varchar2(10)      ,/* 狀態碼 */
gzoy001       number(10,0)      ,/* 調整編號 */
gzoy002       varchar2(6)      ,/* 調整語系 */
gzoy003       varchar2(500)      ,/* 調整前語詞 */
gzoy004       varchar2(1)      ,/* 是否為整詞 */
gzoy005       varchar2(6)      ,/* 參考語系 */
gzoy006       varchar2(500)      ,/* 參考語詞 */
gzoy007       varchar2(255)      ,/* 調整原因說明 */
gzoy008       varchar2(500)      ,/* 調整後語詞 */
gzoy009       varchar2(1)      ,/* 調整狀況 */
gzoyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzoyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzoyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzoyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzoyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzoyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzoyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzoyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzoyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzoyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzoyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzoyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzoyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzoyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzoyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzoyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzoyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzoyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzoyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzoyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzoyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzoyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzoyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzoyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzoyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzoyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzoyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzoyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzoyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzoyud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzoy_t add constraint gzoy_pk primary key (gzoy001) enable validate;

create unique index gzoy_pk on gzoy_t (gzoy001);

grant select on gzoy_t to tiptop;
grant update on gzoy_t to tiptop;
grant delete on gzoy_t to tiptop;
grant insert on gzoy_t to tiptop;

exit;
