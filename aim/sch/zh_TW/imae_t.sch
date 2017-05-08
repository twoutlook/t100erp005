/* 
================================================================================
檔案代號:imae_t
檔案名稱:料件據點製造檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imae_t
(
imaeent       number(5)      ,/* 企業編號 */
imaesite       varchar2(10)      ,/* 營運據點 */
imae001       varchar2(40)      ,/* 料件編號 */
imae011       varchar2(10)      ,/* 生管分群 */
imae012       varchar2(20)      ,/* 計畫員 */
imae013       varchar2(10)      ,/* 生產型態 */
imae014       varchar2(10)      ,/* 領發料機制 */
imae015       number(20,6)      ,/* 生產損耗率 */
imae016       varchar2(10)      ,/* 生產單位 */
imae017       number(20,6)      ,/* 生產單位批量 */
imae018       number(20,6)      ,/* 最小生產數量 */
imae019       varchar2(10)      ,/* 生產批量控管方式 */
imae020       number(20,6)      ,/* 生產超交率 */
imae021       varchar2(10)      ,/* 生產命令展開選項 */
imae022       number(20,6)      ,/* 工單拆分批量 */
imae023       varchar2(10)      ,/* 必要性質 */
imae031       varchar2(5)      ,/* 預設工單別 */
imae032       varchar2(40)      ,/* 製程料號 */
imae033       varchar2(10)      ,/* 預設製程編號 */
imae034       varchar2(10)      ,/* 預設部門/供應商 */
imae035       varchar2(10)      ,/* 預設成本中心 */
imae036       varchar2(1)      ,/* 允許需求合併生產 */
imae037       varchar2(30)      ,/* 預設BOM特性 */
imae041       varchar2(10)      ,/* 預設入庫庫位 */
imae042       varchar2(10)      ,/* 預設入庫儲位 */
imae051       number(15,3)      ,/* 標準人工工時 */
imae052       number(15,3)      ,/* 標準機器工時 */
imae061       varchar2(1)      ,/* MPS計算 */
imae062       number(15,3)      ,/* 預測無效天數 */
imae063       number(15,3)      ,/* 供給匯整時距 */
imae064       number(15,3)      ,/* 計畫匯整時距 */
imae065       number(20,6)      ,/* 建議新單量 */
imae066       date      ,/* 預計停產日 */
imae071       number(15,3)      ,/* 固定生產前置時間 */
imae072       number(15,3)      ,/* 變動生產前置時間 */
imae073       number(20,6)      ,/* 變動批量 */
imae074       number(15,3)      ,/* QC前置時間 */
imae075       number(15,3)      ,/* 累計前置時間 */
imae076       number(15,3)      ,/* 嚴守交期前置時間 */
imae077       number(20,6)      ,/* 計畫批次移轉量 */
imae078       number(15,3)      ,/* 物料規劃移轉時間 */
imae079       number(15,3)      ,/* 主料需求保留天數 */
imae080       varchar2(1)      ,/* 關鍵物料 */
imae081       varchar2(10)      ,/* 發料單位 */
imae082       number(20,6)      ,/* 發料單位批量 */
imae083       number(20,6)      ,/* 最小發料數量 */
imae084       varchar2(10)      ,/* 發料批量控管方式 */
imae085       number(15,3)      ,/* 預設投料時距 */
imae091       varchar2(1)      ,/* 倒扣料 */
imae092       varchar2(1)      ,/* 發料前調撥 */
imae101       varchar2(10)      ,/* 預設發料庫位 */
imae102       varchar2(10)      ,/* 預設發料儲位 */
imae103       varchar2(10)      ,/* 預設退料庫位 */
imae104       varchar2(10)      ,/* 預設退料儲位 */
imae111       varchar2(10)      ,/* 品管分群 */
imae112       varchar2(20)      ,/* 品管員 */
imae113       varchar2(10)      ,/* 檢驗單位 */
imae114       varchar2(1)      ,/* 進料檢驗否 */
imae115       varchar2(10)      ,/* 檢驗程度 */
imae116       varchar2(10)      ,/* 檢驗水準 */
imae117       varchar2(10)      ,/* 檢驗級數 */
imae118       number(15,3)      ,/* 庫存失效提前通知天數 */
imae119       number(15,3)      ,/* 檢驗標準工時 */
imae120       varchar2(1)      ,/* 使用品檢判定等級功能 */
imaeownid       varchar2(20)      ,/* 資料所有者 */
imaeowndp       varchar2(10)      ,/* 資料所屬部門 */
imaecrtid       varchar2(20)      ,/* 資料建立者 */
imaecrtdt       timestamp(0)      ,/* 資料創建日 */
imaecrtdp       varchar2(10)      ,/* 資料建立部門 */
imaemodid       varchar2(20)      ,/* 資料修改者 */
imaemoddt       timestamp(0)      ,/* 最近修改日 */
imaecnfid       varchar2(20)      ,/* 資料確認者 */
imaecnfdt       timestamp(0)      ,/* 資料確認日 */
imaestus       varchar2(10)      ,/* 資料有效碼 */
imaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imaeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
imae086       varchar2(1)      /* 庫存可混批供給 */
);
alter table imae_t add constraint imae_pk primary key (imaeent,imaesite,imae001) enable validate;

create  index imae_01 on imae_t (imae011);
create  index imae_02 on imae_t (imae111);
create unique index imae_pk on imae_t (imaeent,imaesite,imae001);

grant select on imae_t to tiptop;
grant update on imae_t to tiptop;
grant delete on imae_t to tiptop;
grant insert on imae_t to tiptop;

exit;
