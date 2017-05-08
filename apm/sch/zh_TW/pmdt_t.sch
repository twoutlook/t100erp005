/* 
================================================================================
檔案代號:pmdt_t
檔案名稱:收貨/入庫單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdt_t
(
pmdtent       number(5)      ,/* 企業編號 */
pmdtsite       varchar2(10)      ,/* 營運據點 */
pmdtdocno       varchar2(20)      ,/* 單據編號 */
pmdtseq       number(10,0)      ,/* 項次 */
pmdt001       varchar2(20)      ,/* 採購單號 */
pmdt002       number(10,0)      ,/* 採購項次 */
pmdt003       number(10,0)      ,/* 採購項序 */
pmdt004       number(10,0)      ,/* 採購分批序 */
pmdt005       varchar2(10)      ,/* 子件特性 */
pmdt006       varchar2(40)      ,/* 料件編號 */
pmdt007       varchar2(256)      ,/* 產品特徵 */
pmdt008       varchar2(40)      ,/* 包裝容器 */
pmdt009       varchar2(10)      ,/* 作業編號 */
pmdt010       varchar2(10)      ,/* 作業序 */
pmdt011       number(10,0)      ,/* 沖銷順序 */
pmdt016       varchar2(10)      ,/* 庫位 */
pmdt017       varchar2(10)      ,/* 儲位 */
pmdt018       varchar2(30)      ,/* 批號 */
pmdt019       varchar2(10)      ,/* 收貨/入庫單位 */
pmdt020       number(20,6)      ,/* 收貨/入庫數量 */
pmdt021       varchar2(10)      ,/* 參考單位 */
pmdt022       number(20,6)      ,/* 參考數量 */
pmdt023       varchar2(10)      ,/* 計價單位 */
pmdt024       number(20,6)      ,/* 計價數量 */
pmdt025       varchar2(10)      ,/* 緊急度 */
pmdt026       varchar2(1)      ,/* 檢驗否 */
pmdt027       varchar2(20)      ,/* 收貨單號 */
pmdt028       number(10,0)      ,/* 收貨項次 */
pmdt036       number(20,6)      ,/* 單價 */
pmdt037       number(5,2)      ,/* 稅率 */
pmdt038       number(20,6)      ,/* 未稅金額 */
pmdt039       number(20,6)      ,/* 含稅金額 */
pmdt040       varchar2(10)      ,/* 價格核決 */
pmdt041       varchar2(1)      ,/* 保稅否 */
pmdt042       varchar2(10)      ,/* 取價來源 */
pmdt043       varchar2(20)      ,/* 價格參考單號 */
pmdt044       number(20,6)      ,/* 取出單價 */
pmdt045       number(20,6)      ,/* 價差比 */
pmdt046       varchar2(10)      ,/* 稅別 */
pmdt047       number(20,6)      ,/* 稅額 */
pmdt051       varchar2(10)      ,/* 理由碼 */
pmdt052       varchar2(10)      ,/* 狀態碼 */
pmdt053       number(20,6)      ,/* 允收數量 */
pmdt054       number(20,6)      ,/* 已入庫量 */
pmdt055       number(20,6)      ,/* 驗退量 */
pmdt056       number(20,6)      ,/* 主帳套已請款數量 */
pmdt057       number(20,6)      ,/* 帳套二已請款數量 */
pmdt058       number(20,6)      ,/* 帳套三已請款數量 */
pmdt059       varchar2(255)      ,/* 備註 */
pmdt060       varchar2(30)      ,/* 供應商批號 */
pmdt061       number(20,6)      ,/* 供應商送貨數量 */
pmdt062       varchar2(1)      ,/* 多庫儲批收貨入庫 */
pmdt063       varchar2(30)      ,/* 庫存管理特徵 */
pmdt064       varchar2(20)      ,/* 出貨單號 */
pmdt065       number(10,0)      ,/* 出貨單項次 */
pmdt066       number(20,6)      ,/* 主帳套暫估數量 */
pmdt067       number(20,6)      ,/* 帳套二暫估數量 */
pmdt068       number(20,6)      ,/* 帳套三暫估數量 */
pmdt069       number(20,6)      ,/* 已開發票數量 */
pmdt081       varchar2(20)      ,/* QC單號 */
pmdt082       number(10,0)      ,/* QC判定項次 */
pmdt083       varchar2(10)      ,/* 判定結果 */
pmdt084       varchar2(1)      ,/* 須自立AP否 */
pmdt085       varchar2(10)      ,/* 多角流程編號 */
pmdt086       varchar2(10)      ,/* 採購多角性質 */
pmdt087       varchar2(10)      ,/* 採購單開立據點 */
pmdt088       varchar2(255)      ,/* 存貨備註 */
pmdt089       date      ,/* 有效日期 */
pmdt900       number(20,6)      ,/* 保留欄位str */
pmdt999       number(20,6)      ,/* 保留欄位end */
pmdtud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdtud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdtud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdtud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdtud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdtud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdtud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdtud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdtud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdtud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdtud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdtud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdtud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdtud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdtud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdtud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdtud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdtud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdtud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdtud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdtud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdtud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdtud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdtud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdtud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdtud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdtud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdtud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdtud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdtud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmdt200       varchar2(40)      ,/* 商品條碼 */
pmdt201       varchar2(10)      ,/* 收貨包裝單位 */
pmdt202       number(20,6)      ,/* 收貨包裝數量 */
pmdt203       varchar2(10)      ,/* 採購組織 */
pmdt204       varchar2(10)      ,/* 採購中心 */
pmdt205       varchar2(10)      ,/* 要貨組織 */
pmdt206       varchar2(20)      ,/* 預約收貨單號 */
pmdt207       number(10,0)      ,/* 預約收貨項次 */
pmdt208       varchar2(10)      ,/* 採購通路 */
pmdt209       varchar2(10)      ,/* 通路性質 */
pmdt210       varchar2(10)      ,/* 經營方式 */
pmdt211       varchar2(10)      ,/* 結算方式 */
pmdt212       varchar2(20)      ,/* 合約編號 */
pmdt213       varchar2(20)      ,/* 協議編號 */
pmdtorga       varchar2(10)      ,/* 帳務組織 */
pmdt070       varchar2(20)      ,/* 參考單號 */
pmdt071       number(10,0)      ,/* 參考項次 */
pmdt214       varchar2(10)      ,/* 採購方式 */
pmdt215       varchar2(10)      ,/* 最終收貨組織 */
pmdt048       number(10,0)      ,/* 價格參考項次 */
pmdt216       varchar2(20)      ,/* 退貨申請單號 */
pmdt217       number(10,0)      ,/* 退貨申請項次 */
pmdt090       number(20,6)      ,/* 借貨還價數量 */
pmdt091       number(20,6)      ,/* 借貨還價參考數量 */
pmdt092       number(20,6)      ,/* 還價未稅金額 */
pmdt093       number(20,6)      ,/* 還價含稅金額 */
pmdt218       number(20,6)      ,/* 採購價 */
pmdt219       date      ,/* 製造日期 */
pmdt072       varchar2(20)      ,/* 專案編號 */
pmdt073       varchar2(30)      ,/* WBS */
pmdt074       varchar2(30)      ,/* 活動編號 */
pmdt227       varchar2(80)      ,/* 補貨規格說明 */
pmdt049       varchar2(20)      ,/* 發票編號 */
pmdt050       varchar2(20)      ,/* 發票號碼 */
pmdt075       varchar2(24)      ,/* 預算細項 */
pmdt220       varchar2(10)      ,/* 商品品類 */
pmdt221       varchar2(10)      /* 來源單據商品品類 */
);
alter table pmdt_t add constraint pmdt_pk primary key (pmdtent,pmdtdocno,pmdtseq) enable validate;

create  index pmdt_n on pmdt_t (pmdtent,pmdt001,pmdt002,pmdt003,pmdt004);
create unique index pmdt_pk on pmdt_t (pmdtent,pmdtdocno,pmdtseq);

grant select on pmdt_t to tiptop;
grant update on pmdt_t to tiptop;
grant delete on pmdt_t to tiptop;
grant insert on pmdt_t to tiptop;

exit;
