/* 
================================================================================
檔案代號:stat_t
檔案名稱:計算及條件基準配置資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stat_t
(
statent       number(5)      ,/* 企業編號 */
stat001       varchar2(10)      ,/* 經營方式 */
stat002       varchar2(10)      ,/* 結算類型 */
stat003       varchar2(10)      ,/* 基準編號 */
statownid       varchar2(20)      ,/* 資料所有者 */
statowndp       varchar2(10)      ,/* 資料所屬部門 */
statcrtid       varchar2(20)      ,/* 資料建立者 */
statcrtdp       varchar2(10)      ,/* 資料建立部門 */
statcrtdt       timestamp(0)      ,/* 資料創建日 */
statmodid       varchar2(20)      ,/* 資料修改者 */
statmoddt       timestamp(0)      ,/* 最近修改日 */
statud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
statud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
statud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
statud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
statud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
statud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
statud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
statud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
statud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
statud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
statud011       number(20,6)      ,/* 自定義欄位(數字)011 */
statud012       number(20,6)      ,/* 自定義欄位(數字)012 */
statud013       number(20,6)      ,/* 自定義欄位(數字)013 */
statud014       number(20,6)      ,/* 自定義欄位(數字)014 */
statud015       number(20,6)      ,/* 自定義欄位(數字)015 */
statud016       number(20,6)      ,/* 自定義欄位(數字)016 */
statud017       number(20,6)      ,/* 自定義欄位(數字)017 */
statud018       number(20,6)      ,/* 自定義欄位(數字)018 */
statud019       number(20,6)      ,/* 自定義欄位(數字)019 */
statud020       number(20,6)      ,/* 自定義欄位(數字)020 */
statud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
statud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
statud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
statud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
statud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
statud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
statud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
statud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
statud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
statud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stat_t add constraint stat_pk primary key (statent,stat001,stat002,stat003) enable validate;

create unique index stat_pk on stat_t (statent,stat001,stat002,stat003);

grant select on stat_t to tiptop;
grant update on stat_t to tiptop;
grant delete on stat_t to tiptop;
grant insert on stat_t to tiptop;

exit;
