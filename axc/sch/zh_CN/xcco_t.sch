/* 
================================================================================
檔案代號:xcco_t
檔案名稱:本期庫存成本調整檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcco_t
(
xccoent       number(5)      ,/* 企業編號 */
xccold       varchar2(5)      ,/* 帳套 */
xccocomp       varchar2(10)      ,/* 法人組織 */
xcco001       varchar2(1)      ,/* 帳套本位幣順序 */
xcco002       varchar2(30)      ,/* 成本域 */
xcco003       varchar2(10)      ,/* 成本計算類型 */
xcco004       number(5,0)      ,/* 年度 */
xcco005       number(5,0)      ,/* 期別 */
xcco006       varchar2(40)      ,/* 料件編號 */
xcco007       varchar2(256)      ,/* 特性 */
xcco008       varchar2(30)      ,/* 批號 */
xcco009       varchar2(20)      ,/* 參考單號 */
xcco010       varchar2(1)      ,/* 資料來源 */
xcco011       varchar2(80)      ,/* 調整說明 */
xcco102       number(20,6)      ,/* 當月調整金額-金額合計 */
xcco102a       number(20,6)      ,/* 當月調整金額-材料 */
xcco102b       number(20,6)      ,/* 當月調整金額-人工 */
xcco102c       number(20,6)      ,/* 當月調整金額-委外加工 */
xcco102d       number(20,6)      ,/* 當月調整金額-制費一 */
xcco102e       number(20,6)      ,/* 當月調整金額-制費二 */
xcco102f       number(20,6)      ,/* 當月調整金額-制費三 */
xcco102g       number(20,6)      ,/* 當月調整金額-制費四 */
xcco102h       number(20,6)      ,/* 當月調整金額-制費五 */
xccoownid       varchar2(20)      ,/* 資料所有者 */
xccoowndp       varchar2(10)      ,/* 資料所屬部門 */
xccocrtid       varchar2(20)      ,/* 資料建立者 */
xccocrtdp       varchar2(10)      ,/* 資料建立部門 */
xccocrtdt       timestamp(0)      ,/* 資料創建日 */
xccomodid       varchar2(20)      ,/* 資料修改者 */
xccomoddt       timestamp(0)      ,/* 最近修改日 */
xccocnfid       varchar2(20)      ,/* 資料確認者 */
xccocnfdt       timestamp(0)      ,/* 資料確認日 */
xccopstid       varchar2(20)      ,/* 資料過帳者 */
xccopstdt       timestamp(0)      ,/* 資料過帳日 */
xccostus       varchar2(10)      ,/* 狀態碼 */
xccoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xccoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xccoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xccoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xccoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xccoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xccoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xccoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xccoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xccoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xccoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xccoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xccoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xccoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xccoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xccoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xccoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xccoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xccoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xccoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xccoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xccoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xccoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xccoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xccoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xccoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xccoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xccoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xccoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xccoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcco_t add constraint xcco_pk primary key (xccoent,xccold,xcco001,xcco002,xcco003,xcco004,xcco005,xcco006,xcco007,xcco008,xcco009) enable validate;

create unique index xcco_pk on xcco_t (xccoent,xccold,xcco001,xcco002,xcco003,xcco004,xcco005,xcco006,xcco007,xcco008,xcco009);

grant select on xcco_t to tiptop;
grant update on xcco_t to tiptop;
grant delete on xcco_t to tiptop;
grant insert on xcco_t to tiptop;

exit;
