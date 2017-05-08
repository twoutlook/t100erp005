/* 
================================================================================
檔案代號:imbe_t
檔案名稱:料件申請料號據點製造檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table imbe_t
(
imbeent       number(5)      ,/* 企業編號 */
imbesite       varchar2(10)      ,/* 營運據點 */
imbe001       varchar2(40)      ,/* 料件編號 */
imbe011       varchar2(10)      ,/* 生管分群 */
imbe012       varchar2(20)      ,/* 計畫員 */
imbe013       varchar2(10)      ,/* 生產型態 */
imbe014       varchar2(10)      ,/* 領發料機制 */
imbe015       number(20,6)      ,/* 生產損耗率 */
imbe016       varchar2(10)      ,/* 生產單位 */
imbe017       number(20,6)      ,/* 生產單位批量 */
imbe018       number(20,6)      ,/* 最小生產數量 */
imbe019       varchar2(10)      ,/* 生產批量控管方式 */
imbe020       number(20,6)      ,/* 生產超交率 */
imbe021       varchar2(10)      ,/* 生產命令展開選項 */
imbe022       number(20,6)      ,/* 工單拆分批量 */
imbe023       varchar2(10)      ,/* 必要性質 */
imbe031       varchar2(5)      ,/* 預設工單別 */
imbe032       varchar2(40)      ,/* 製程料號 */
imbe033       varchar2(10)      ,/* 預設製程編號 */
imbe034       varchar2(10)      ,/* 預設部門/廠商 */
imbe035       varchar2(10)      ,/* 預設成本中心 */
imbe036       varchar2(1)      ,/* 允許需求合併生產 */
imbe037       varchar2(30)      ,/* 預設BOM特性 */
imbe041       varchar2(10)      ,/* 預設入庫庫位 */
imbe042       varchar2(10)      ,/* 預設入庫儲位 */
imbe051       number(15,3)      ,/* 標準人工工時 */
imbe052       number(15,3)      ,/* 標準機器工時 */
imbe061       varchar2(1)      ,/* MPS計算 */
imbe062       number(15,3)      ,/* 預測無效天數 */
imbe063       number(15,3)      ,/* 需求匯整時距 */
imbe064       number(15,3)      ,/* 供給匯整時距 */
imbe065       number(20,6)      ,/* 建議新單量 */
imbe066       date      ,/* 預計停產日 */
imbe071       number(15,3)      ,/* 固定生產前置時間 */
imbe072       number(15,3)      ,/* 變動生產前置時間 */
imbe073       number(20,6)      ,/* 變動批量 */
imbe074       number(15,3)      ,/* QC前置時間 */
imbe075       number(15,3)      ,/* 累計前置時間 */
imbe076       number(15,3)      ,/* 嚴守交期前置時間 */
imbe077       number(20,6)      ,/* 計畫批次移轉量 */
imbe078       number(15,3)      ,/* 物規劃移轉時間 */
imbe079       number(15,3)      ,/* 主料需求保留天數 */
imbe080       varchar2(1)      ,/* 關鍵物料 */
imbe081       varchar2(10)      ,/* 發料單位 */
imbe082       number(20,6)      ,/* 發料單位批量 */
imbe083       number(20,6)      ,/* 最小發料數量 */
imbe084       varchar2(10)      ,/* 發料批量控管方式 */
imbe085       number(15,3)      ,/* 預設投料時距 */
imbe091       varchar2(1)      ,/* 倒扣料 */
imbe092       varchar2(1)      ,/* 發料前調撥 */
imbe101       varchar2(10)      ,/* 預設發料庫位 */
imbe102       varchar2(10)      ,/* 預設發料儲位 */
imbe103       varchar2(10)      ,/* 預設退料庫位 */
imbe104       varchar2(10)      ,/* 預設退料儲位 */
imbe111       varchar2(10)      ,/* 品管分群 */
imbe112       varchar2(20)      ,/* 品管員 */
imbe113       varchar2(10)      ,/* 檢驗單位 */
imbe114       varchar2(1)      ,/* 進料檢驗否 */
imbe115       varchar2(10)      ,/* 檢驗程度 */
imbe116       varchar2(10)      ,/* 檢驗水準 */
imbe117       varchar2(10)      ,/* 檢驗級數 */
imbe118       number(15,3)      ,/* 庫存失效提前通知天數 */
imbe119       number(15,3)      ,/* 檢驗標準工時 */
imbe120       varchar2(1)      ,/* 使用品檢判定等級功能 */
imbedocno       varchar2(20)      ,/* 申請單號 */
imbeownid       varchar2(20)      ,/* 資料所有者 */
imbeowndp       varchar2(10)      ,/* 資料所屬部門 */
imbecrtid       varchar2(20)      ,/* 資料建立者 */
imbecrtdt       timestamp(0)      ,/* 資料創建日 */
imbecrtdp       varchar2(10)      ,/* 資料建立部門 */
imbemodid       varchar2(20)      ,/* 資料修改者 */
imbemoddt       timestamp(0)      ,/* 最近修改日 */
imbecnfid       varchar2(20)      ,/* 資料確認者 */
imbecnfdt       timestamp(0)      ,/* 資料確認日 */
imbepstid       varchar2(20)      ,/* 資料過帳者 */
imbepstdt       timestamp(0)      ,/* 資料過帳日 */
imbeacti       varchar2(1)      ,/* 資料有效碼 */
imbestus       varchar2(10)      ,/* 狀態碼 */
imbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imbe_t add constraint imbe_pk primary key (imbeent,imbesite,imbedocno) enable validate;

create  index imbe_01 on imbe_t (imbe001);
create  index imbe_02 on imbe_t (imbe011);
create  index imbe_03 on imbe_t (imbe111);
create unique index imbe_pk on imbe_t (imbeent,imbesite,imbedocno);

grant select on imbe_t to tiptop;
grant update on imbe_t to tiptop;
grant delete on imbe_t to tiptop;
grant insert on imbe_t to tiptop;

exit;
