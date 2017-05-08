/* 
================================================================================
檔案代號:ooei_t
檔案名稱:組織分群基本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooei_t
(
ooeient       number(5)      ,/* 企業編號 */
ooei001       varchar2(10)      ,/* 組織分群編號 */
ooei003       varchar2(10)      ,/* 法人否 */
ooei004       varchar2(5)      ,/* 單據別參照表號 */
ooei006       varchar2(10)      ,/* 所屬國家地區 */
ooei008       varchar2(5)      ,/* 行事曆參照表號 */
ooei009       varchar2(10)      ,/* 製造行事曆對應類別 */
ooei010       varchar2(10)      ,/* 辦公行事曆對應類別 */
ooei011       varchar2(10)      ,/* 專屬國家地區功能 */
ooei013       varchar2(10)      ,/* 日期顯示格式 */
ooei014       varchar2(5)      ,/* 幣別參照表號 */
ooei015       varchar2(5)      ,/* 匯率參照表號 */
ooei016       varchar2(10)      ,/* 主幣別編號 */
ooei017       varchar2(10)      ,/* 法人歸屬 */
ooei018       varchar2(10)      ,/* 時區 */
ooei019       varchar2(10)      ,/* 稅區 */
ooei023       varchar2(10)      ,/* 數字/金額顯示格式 */
ooei201       varchar2(1)      ,/* 營運據點 */
ooei202       varchar2(1)      ,/* 預測組織 */
ooei203       varchar2(1)      ,/* 部門組織 */
ooei204       varchar2(1)      ,/* 核算組織 */
ooei205       varchar2(1)      ,/* 預算組織 */
ooei206       varchar2(1)      ,/* 資金組織 */
ooei207       varchar2(1)      ,/* 資產組織 */
ooei208       varchar2(1)      ,/* 銷售組織 */
ooei209       varchar2(1)      ,/* 銷售範圍 */
ooei210       varchar2(1)      ,/* 採購組織 */
ooei211       varchar2(1)      ,/* 物流組織 */
ooei212       varchar2(1)      ,/* 結算組織 */
ooei213       varchar2(1)      ,/* nouse */
ooei214       varchar2(1)      ,/* nouse */
ooei215       varchar2(1)      ,/* nouse */
ooei216       varchar2(1)      ,/* nouse */
ooei217       varchar2(1)      ,/* nouse */
ooei301       varchar2(1)      ,/* 營銷中心 */
ooei302       varchar2(1)      ,/* 配送中心 */
ooei303       varchar2(1)      ,/* 採購中心 */
ooei304       varchar2(1)      ,/* 門店 */
ooei305       varchar2(1)      ,/* 辦事處 */
ooei306       varchar2(1)      ,/* nouse */
ooei307       varchar2(1)      ,/* nouse */
ooei308       varchar2(1)      ,/* nouse */
ooei309       varchar2(1)      ,/* nouse */
ooei310       varchar2(1)      ,/* nouse */
ooeiownid       varchar2(20)      ,/* 資料所有者 */
ooeiowndp       varchar2(10)      ,/* 資料所屬部門 */
ooeicrtid       varchar2(20)      ,/* 資料建立者 */
ooeicrtdp       varchar2(10)      ,/* 資料建立部門 */
ooeicrtdt       timestamp(0)      ,/* 資料創建日 */
ooeimodid       varchar2(20)      ,/* 資料修改者 */
ooeimoddt       timestamp(0)      ,/* 最近修改日 */
ooeistus       varchar2(10)      ,/* 狀態碼 */
ooeiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooeiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooeiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooeiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooeiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooeiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooeiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooeiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooeiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooeiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooeiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooeiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooeiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooeiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooeiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooeiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooeiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooeiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooeiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooeiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooeiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooeiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooeiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooeiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooeiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooeiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooeiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooeiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooeiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooeiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooei_t add constraint ooei_pk primary key (ooeient,ooei001) enable validate;

create unique index ooei_pk on ooei_t (ooeient,ooei001);

grant select on ooei_t to tiptop;
grant update on ooei_t to tiptop;
grant delete on ooei_t to tiptop;
grant insert on ooei_t to tiptop;

exit;
