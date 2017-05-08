/* 
================================================================================
檔案代號:gzpa_t
檔案名稱:排程設定主表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzpa_t
(
gzpaent       number(5)      ,/* 企業編號 */
gzpaownid       varchar2(20)      ,/* 資料所有者 */
gzpaowndp       varchar2(10)      ,/* 資料所屬部門 */
gzpacrtid       varchar2(20)      ,/* 資料建立者 */
gzpacrtdp       varchar2(10)      ,/* 資料建立部門 */
gzpacrtdt       timestamp(0)      ,/* 資料創建日 */
gzpamodid       varchar2(20)      ,/* 資料修改者 */
gzpamoddt       timestamp(0)      ,/* 最近修改日 */
gzpastus       varchar2(10)      ,/* 狀態碼 */
gzpa001       varchar2(40)      ,/* 排程編號 */
gzpa002       varchar2(80)      ,/* 排程說明 */
gzpa003       varchar2(1)      ,/* 執行類型 */
gzpa004       timestamp(0)      ,/* 排程起始時間 */
gzpa005       timestamp(0)      ,/* 排程結束時間 */
gzpa006       date      ,/* 指定執行日期 */
gzpa007       varchar2(8)      ,/* 指定執行時間 */
gzpa008       varchar2(1)      ,/* 執行月別種類 */
gzpa009       varchar2(80)      ,/* 執行月份 */
gzpa010       varchar2(1)      ,/* 執行周別種類 */
gzpa011       varchar2(80)      ,/* 執行周別 */
gzpa012       varchar2(1)      ,/* 執行日別種類 */
gzpa013       varchar2(80)      ,/* 執行週間 */
gzpa014       varchar2(80)      ,/* 執行日別 */
gzpa015       varchar2(1)      ,/* 時間時段種類 */
gzpa016       varchar2(8)      ,/* 週期類指定執行時間 */
gzpa017       varchar2(8)      ,/* 時段一起始時間 */
gzpa018       varchar2(8)      ,/* 時段一結束時間 */
gzpa019       number(5,0)      ,/* 時段一間格數 */
gzpa020       varchar2(1)      ,/* 時段一間格單位 */
gzpa021       varchar2(8)      ,/* 時段二起始時間 */
gzpa022       varchar2(8)      ,/* 時段二結束時間 */
gzpa023       number(5,0)      ,/* 時段二間格數 */
gzpa024       varchar2(1)      ,/* 時段二間格單位 */
gzpa025       varchar2(8)      ,/* 時段三起始時間 */
gzpa026       varchar2(8)      ,/* 時段三結束時間 */
gzpa027       number(5,0)      ,/* 時段三間格數 */
gzpa028       varchar2(1)      ,/* 時段三間格單位 */
gzpa029       varchar2(1)      ,/* 執行日遇到假日 */
gzpa030       varchar2(1)      ,/* 遇到假日處理方法 */
gzpa031       varchar2(1)      ,/* 前一程序未完成時不執行新程序 */
gzpaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzpaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzpaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzpaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzpaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzpaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzpaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzpaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzpaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzpaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzpaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzpaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzpaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzpaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzpaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzpaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzpaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzpaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzpaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzpaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzpaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzpaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzpaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzpaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzpaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzpaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzpaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzpaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzpaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzpaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzpa032       varchar2(80)      ,/* 超過預估時間通知郵件位置 */
gzpa033       number(5,0)      /* 預估最長執行時間(分鐘) */
);
alter table gzpa_t add constraint gzpa_pk primary key (gzpaent,gzpa001) enable validate;

create unique index gzpa_pk on gzpa_t (gzpaent,gzpa001);

grant select on gzpa_t to tiptop;
grant update on gzpa_t to tiptop;
grant delete on gzpa_t to tiptop;
grant insert on gzpa_t to tiptop;

exit;
