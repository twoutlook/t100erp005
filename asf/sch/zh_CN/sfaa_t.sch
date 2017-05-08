/* 
================================================================================
檔案代號:sfaa_t
檔案名稱:工單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table sfaa_t
(
sfaaent       number(5)      ,/* 企業編號 */
sfaaownid       varchar2(20)      ,/* 資料所有者 */
sfaaowndp       varchar2(10)      ,/* 資料所有部門 */
sfaacrtid       varchar2(20)      ,/* 資料建立者 */
sfaacrtdp       varchar2(10)      ,/* 資料建立部門 */
sfaacrtdt       timestamp(0)      ,/* 資料創建日 */
sfaamodid       varchar2(20)      ,/* 資料修改者 */
sfaamoddt       timestamp(0)      ,/* 最近修改日 */
sfaacnfid       varchar2(20)      ,/* 資料確認者 */
sfaacnfdt       timestamp(0)      ,/* 資料確認日 */
sfaapstid       varchar2(20)      ,/* 資料過帳者 */
sfaapstdt       timestamp(0)      ,/* 資料過帳日 */
sfaastus       varchar2(10)      ,/* 狀態碼 */
sfaasite       varchar2(10)      ,/* 營運據點 */
sfaadocno       varchar2(20)      ,/* 單號 */
sfaadocdt       date      ,/* 單據日期 */
sfaa001       number(5,0)      ,/* 變更版本 */
sfaa002       varchar2(20)      ,/* 生管人員 */
sfaa003       varchar2(1)      ,/* 工單類型 */
sfaa004       varchar2(1)      ,/* 發料制度 */
sfaa005       varchar2(20)      ,/* 工單來源 */
sfaa006       varchar2(20)      ,/* 來源單號 */
sfaa007       number(10,0)      ,/* 來源項次 */
sfaa008       number(10,0)      ,/* 來源項序 */
sfaa009       varchar2(10)      ,/* 參考客戶 */
sfaa010       varchar2(40)      ,/* 生產料號 */
sfaa011       varchar2(30)      ,/* 特性 */
sfaa012       number(20,6)      ,/* 生產數量 */
sfaa013       varchar2(10)      ,/* 生產單位 */
sfaa014       varchar2(10)      ,/* BOM版本 */
sfaa015       date      ,/* BOM有效日期 */
sfaa016       varchar2(10)      ,/* 製程編號 */
sfaa017       varchar2(10)      ,/* 部門廠商 */
sfaa018       varchar2(10)      ,/* 協作據點 */
sfaa019       date      ,/* 預計開工日 */
sfaa020       date      ,/* 預計完工日 */
sfaa021       varchar2(20)      ,/* 母工單單號 */
sfaa022       varchar2(20)      ,/* 參考原始單號 */
sfaa023       number(10,0)      ,/* 參考原始項次 */
sfaa024       number(10,0)      ,/* 參考原始項序 */
sfaa025       varchar2(20)      ,/* 前工單單號 */
sfaa026       varchar2(20)      ,/* 料表批號(PBI) */
sfaa027       number(20,6)      ,/* No Use */
sfaa028       varchar2(20)      ,/* 專案代號 */
sfaa029       varchar2(30)      ,/* WBS */
sfaa030       varchar2(30)      ,/* 活動 */
sfaa031       varchar2(10)      ,/* 理由碼 */
sfaa032       number(20,6)      ,/* 緊急比率 */
sfaa033       number(10,0)      ,/* 優先順序 */
sfaa034       varchar2(10)      ,/* 預計入庫庫位 */
sfaa035       varchar2(10)      ,/* 預計入庫儲位 */
sfaa036       varchar2(20)      ,/* 手冊編號 */
sfaa037       varchar2(20)      ,/* 保稅核准文號 */
sfaa038       varchar2(1)      ,/* 保稅核銷 */
sfaa039       varchar2(1)      ,/* 備料已產生 */
sfaa040       varchar2(1)      ,/* 生產途程已確認 */
sfaa041       varchar2(1)      ,/* 凍結 */
sfaa042       varchar2(1)      ,/* 重工 */
sfaa043       varchar2(1)      ,/* 備置 */
sfaa044       varchar2(1)      ,/* FQC */
sfaa045       date      ,/* 實際開始發料日 */
sfaa046       date      ,/* 最後入庫日 */
sfaa047       date      ,/* 生管結案日 */
sfaa048       date      ,/* 成本結案日 */
sfaa049       number(20,6)      ,/* 已發料套數 */
sfaa050       number(20,6)      ,/* 已入庫合格量 */
sfaa051       number(20,6)      ,/* 已入庫不合格量 */
sfaa052       number(20,6)      ,/* Bouns */
sfaa053       number(20,6)      ,/* 工單轉入數量 */
sfaa054       number(20,6)      ,/* 工單轉出數量 */
sfaa055       number(20,6)      ,/* 下線數量 */
sfaa056       number(20,6)      ,/* 報廢數量 */
sfaa057       varchar2(1)      ,/* 委外類型 */
sfaa058       number(20,6)      ,/* 參考數量 */
sfaa059       varchar2(30)      ,/* 預計入庫批號 */
sfaa060       varchar2(10)      ,/* 參考單位 */
sfaa061       varchar2(1)      ,/* 製程 */
sfaa062       varchar2(1)      ,/* 納入APS計算 */
sfaa063       number(5,0)      ,/* 來源分批序 */
sfaa064       number(5,0)      ,/* 參考原始分批序 */
sfaa065       varchar2(10)      ,/* 生管結案狀態 */
sfaa066       varchar2(10)      ,/* 多角流程代碼 */
sfaa067       varchar2(20)      ,/* 多角流程序號 */
sfaa068       varchar2(10)      ,/* 成本中心 */
sfaa069       number(20,6)      ,/* 可供給量 */
sfaa070       date      ,/* 原始預計完工日期 */
sfaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfaa_t add constraint sfaa_pk primary key (sfaaent,sfaadocno) enable validate;

create unique index sfaa_pk on sfaa_t (sfaaent,sfaadocno);

grant select on sfaa_t to tiptop;
grant update on sfaa_t to tiptop;
grant delete on sfaa_t to tiptop;
grant insert on sfaa_t to tiptop;

exit;
