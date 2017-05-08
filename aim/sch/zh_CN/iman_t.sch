/* 
================================================================================
檔案代號:iman_t
檔案名稱:料件據點關務檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table iman_t
(
imanent       number(5)      ,/* 企業編號 */
imansite       varchar2(10)      ,/* 營運據點 */
iman001       varchar2(40)      ,/* 料件編號 */
iman011       varchar2(10)      ,/* 關務分群 */
iman012       varchar2(1)      ,/* 保稅否 */
iman013       varchar2(10)      ,/* 保稅料件型態 */
iman014       varchar2(10)      ,/* 保稅料區分 */
iman021       varchar2(10)      ,/* 保稅統計類別 */
iman022       number(20,6)      ,/* 保稅年度盤差容許率 */
iman023       varchar2(20)      ,/* 稅則編號 */
iman024       number(5,2)      ,/* 保稅應補稅稅率 */
iman025       number(20,6)      ,/* 保稅單價 */
iman031       number(20,6)      ,/* 推廣貿易服務費 */
iman032       varchar2(40)      ,/* 稅則 */
iman033       varchar2(30)      ,/* 帳卡編號 */
iman034       varchar2(1)      ,/* 受託加工成品 */
imanownid       varchar2(20)      ,/* 資料所有者 */
imanowndp       varchar2(10)      ,/* 資料所屬部門 */
imancrtid       varchar2(20)      ,/* 資料建立者 */
imancrtdp       varchar2(10)      ,/* 資料建立部門 */
imancrtdt       timestamp(0)      ,/* 資料創建日 */
imanmodid       varchar2(20)      ,/* 資料修改者 */
imanmoddt       timestamp(0)      ,/* 最近修改日 */
imancnfid       varchar2(20)      ,/* 資料確認者 */
imancnfdt       timestamp(0)      ,/* 資料確認日 */
imanstus       varchar2(10)      ,/* 狀態碼 */
imanud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imanud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imanud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imanud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imanud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imanud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imanud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imanud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imanud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imanud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imanud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imanud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imanud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imanud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imanud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imanud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imanud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imanud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imanud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imanud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imanud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imanud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imanud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imanud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imanud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imanud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imanud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imanud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imanud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imanud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table iman_t add constraint iman_pk primary key (imanent,imansite,iman001) enable validate;

create unique index iman_pk on iman_t (imanent,imansite,iman001);

grant select on iman_t to tiptop;
grant update on iman_t to tiptop;
grant delete on iman_t to tiptop;
grant insert on iman_t to tiptop;

exit;
