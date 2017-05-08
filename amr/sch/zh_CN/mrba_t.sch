/* 
================================================================================
檔案代號:mrba_t
檔案名稱:資源主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mrba_t
(
mrbaent       number(5)      ,/* 企業編號 */
mrbasite       varchar2(10)      ,/* 營運據點 */
mrbaunit       varchar2(10)      ,/* 應用組織 */
mrba000       varchar2(10)      ,/* 資源類型 */
mrba001       varchar2(20)      ,/* 資源編號/車輛編號 */
mrba002       varchar2(20)      ,/* 財產編號 */
mrba003       varchar2(20)      ,/* 附號 */
mrba004       varchar2(255)      ,/* 資源名稱 */
mrba005       varchar2(80)      ,/* 資源簡稱 */
mrba006       number(20,6)      ,/* 資源數量 */
mrba007       varchar2(40)      ,/* 系列號 */
mrba008       varchar2(20)      ,/* 原廠序號 */
mrba009       varchar2(40)      ,/* 資源條碼號 */
mrba010       varchar2(10)      ,/* 資源分類/車輛類型 */
mrba011       varchar2(10)      ,/* 廠牌 */
mrba012       varchar2(10)      ,/* 原產地國家 */
mrba013       varchar2(10)      ,/* 購買廠商 */
mrba014       varchar2(10)      ,/* 維護廠商 */
mrba015       date      ,/* 保固截止日 */
mrba016       varchar2(20)      ,/* 保管人員 */
mrba017       varchar2(10)      ,/* 保管部門 */
mrba018       varchar2(255)      ,/* 存放位置 */
mrba019       varchar2(10)      ,/* 所有權區分 */
mrba020       varchar2(10)      ,/* 所有權據點/客戶 */
mrba021       varchar2(10)      ,/* 專屬作業編號 */
mrba022       varchar2(10)      ,/* 所屬工作站 */
mrba023       number(20,6)      ,/* 資源日產能 */
mrba024       varchar2(10)      ,/* 產能單位 */
mrba025       number(20,6)      ,/* 生產員工數 */
mrba026       number(10,0)      ,/* 順序 */
mrba027       varchar2(10)      ,/* 資源群組 */
mrba028       varchar2(8)      ,/* 稼動日期起始時間 */
mrba029       number(20,6)      ,/* 資源效率 */
mrba031       varchar2(10)      ,/* 壽命計算方式 */
mrba032       date      ,/* 資源取得日期 */
mrba033       date      ,/* 資源啟用日期 */
mrba034       date      ,/* 預估除役日期 */
mrba035       number(20,6)      ,/* 預計運作次數 */
mrba036       number(20,6)      ,/* 每次產品產出權重(分子) */
mrba037       number(20,6)      ,/* 每次產品產出權重(分母) */
mrba038       number(20,6)      ,/* 機器成本率 */
mrba039       varchar2(10)      ,/* 機器成本率計算單位 */
mrba040       varchar2(10)      ,/* 運作成本幣別 */
mrba041       number(20,6)      ,/* 累積運作次數 */
mrba042       varchar2(10)      ,/* 超出壽命控管方式 */
mrba050       varchar2(20)      ,/* 車牌號碼 */
mrba051       varchar2(10)      ,/* 車型 */
mrba052       number(5,0)      ,/* 年份 */
mrba053       number(10,0)      ,/* 排氣量 */
mrba054       date      ,/* 出廠日期 */
mrba055       varchar2(20)      ,/* 引擎號碼 */
mrba056       varchar2(20)      ,/* 底盤號碼 */
mrba057       number(20,6)      ,/* 載重量 */
mrba058       varchar2(10)      ,/* 載重量單位 */
mrba059       number(20,6)      ,/* 承載容積 */
mrba060       varchar2(10)      ,/* 承載容積單位 */
mrba061       varchar2(20)      ,/* 駕駛人員 */
mrba062       varchar2(20)      ,/* 隨車人員1 */
mrba063       varchar2(20)      ,/* 隨車人員2 */
mrba064       varchar2(20)      ,/* 隨車人員3 */
mrba065       varchar2(10)      ,/* 車隊編號 */
mrba100       varchar2(10)      ,/* 資源狀態/車輛狀態 */
mrba101       varchar2(255)      ,/* 備註說明 */
mrba102       varchar2(255)      ,/* 二級存放位置 */
mrba103       varchar2(10)      ,/* 嫁動班別 */
mrba104       number(20,6)      ,/* 已借出數量 */
mrbaownid       varchar2(20)      ,/* 資料所有者 */
mrbaowndp       varchar2(10)      ,/* 資料所屬部門 */
mrbacrtid       varchar2(20)      ,/* 資料建立者 */
mrbacrtdp       varchar2(10)      ,/* 資料建立部門 */
mrbacrtdt       timestamp(0)      ,/* 資料創建日 */
mrbamodid       varchar2(20)      ,/* 資料修改者 */
mrbamoddt       timestamp(0)      ,/* 最近修改日 */
mrbacnfid       varchar2(20)      ,/* 資料確認者 */
mrbacnfdt       timestamp(0)      ,/* 資料確認日 */
mrbastus       varchar2(10)      ,/* 狀態碼 */
mrbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrbaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mrba066       varchar2(10)      /* 卡片編號 */
);
alter table mrba_t add constraint mrba_pk primary key (mrbaent,mrbasite,mrba001) enable validate;

create  index mrba_01 on mrba_t (mrba002,mrba003);
create unique index mrba_pk on mrba_t (mrbaent,mrbasite,mrba001);

grant select on mrba_t to tiptop;
grant update on mrba_t to tiptop;
grant delete on mrba_t to tiptop;
grant insert on mrba_t to tiptop;

exit;
