/* 
================================================================================
檔案代號:prcf_t
檔案名稱:促銷方案主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table prcf_t
(
prcfent       number(5)      ,/* 企業編號 */
prcfunit       varchar2(10)      ,/* 應用組織 */
prcfsite       varchar2(10)      ,/* 營運據點 */
prcfdocdt       date      ,/* 制定日期 */
prcf001       varchar2(30)      ,/* 方案編號 */
prcf002       varchar2(30)      ,/* 活動計劃 */
prcf003       varchar2(20)      ,/* 人員 */
prcf004       varchar2(10)      ,/* 部門 */
prcf005       varchar2(10)      ,/* 促銷類型 */
prcf006       varchar2(10)      ,/* 促銷產品類別 */
prcf007       varchar2(10)      ,/* 檔期類型 */
prcf008       varchar2(10)      ,/* 活動等級 */
prcf009       date      ,/* 起始日期 */
prcf010       date      ,/* 截止日期 */
prcf011       varchar2(1)      ,/* 常規配贈計算否 */
prcf012       varchar2(1)      ,/* 市場費用計算否 */
prcf013       varchar2(30)      ,/* 對比方案 */
prcf014       date      ,/* 對比起始日期 */
prcf015       date      ,/* 對比截止日期 */
prcf016       number(20,6)      ,/* 目標銷售額 */
prcf017       number(20,6)      ,/* 目標實收 */
prcf018       number(20,6)      ,/* 預計費用 */
prcf019       number(20,6)      ,/* 目標收益 */
prcf020       number(20,6)      ,/* 預計投入比 */
prcf021       number(20,6)      ,/* 銷售額 */
prcf022       number(20,6)      ,/* 實收金額 */
prcf023       number(20,6)      ,/* 促銷收益 */
prcf024       number(20,6)      ,/* 銷售完成率 */
prcf025       number(20,6)      ,/* 實收完成率 */
prcf026       number(20,6)      ,/* 收益完成率 */
prcf027       number(20,6)      ,/* 日均銷售 */
prcf028       number(20,6)      ,/* 日均實收 */
prcf029       number(20,6)      ,/* 日均收益 */
prcf030       number(20,6)      ,/* 促銷期銷售增長率 */
prcf031       number(20,6)      ,/* 促銷期實收增長率 */
prcf032       number(20,6)      ,/* 促銷期收益增長率 */
prcf033       number(20,6)      ,/* 非促銷期銷售增長率 */
prcf034       number(20,6)      ,/* 非促銷期實收增長率 */
prcf035       number(20,6)      ,/* 非促銷期收益增長率 */
prcf036       number(20,6)      ,/* 客單量 */
prcf037       number(20,6)      ,/* 日均客單量 */
prcf038       number(20,6)      ,/* 客單價 */
prcf039       number(20,6)      ,/* 日均客單價 */
prcf040       number(20,6)      ,/* 促銷折讓 */
prcf041       number(20,6)      ,/* 促銷折扣率 */
prcf042       number(20,6)      ,/* 費用投入總額 */
prcf043       number(20,6)      ,/* 公司承擔總額 */
prcf044       number(20,6)      ,/* 合作夥伴承擔總額 */
prcf045       number(20,6)      ,/* 費用投入比 */
prcfstus       varchar2(10)      ,/* 狀態碼 */
prcfownid       varchar2(20)      ,/* 資料所有者 */
prcfowndp       varchar2(10)      ,/* 資料所有部門 */
prcfcrtid       varchar2(20)      ,/* 資料建立者 */
prcfcrtdp       varchar2(10)      ,/* 資料建立部門 */
prcfcrtdt       timestamp(0)      ,/* 資料創建日 */
prcfmodid       varchar2(20)      ,/* 資料修改者 */
prcfmoddt       timestamp(0)      ,/* 最近修改日 */
prcfcnfid       varchar2(20)      ,/* 資料確認者 */
prcfcnfdt       timestamp(0)      ,/* 資料確認日 */
prcf098       varchar2(10)      ,/* 應用業態 */
prcfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prcfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prcfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prcfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prcfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prcfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prcfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prcfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prcfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prcfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prcfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prcfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prcfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prcfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prcfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prcfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prcfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prcfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prcfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prcfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prcfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prcfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prcfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prcfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prcfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prcfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prcfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prcfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prcfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prcfud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prcf046       number(5,0)      ,/* 計劃年度 */
prcf047       number(20,6)      ,/* 贈送起點 */
prcf048       number(20,6)      ,/* 贈送金額 */
prcf049       number(20,6)      ,/* 促銷折扣率 */
prcf050       varchar2(10)      ,/* 談判組織 */
prcf051       varchar2(10)      ,/* 促銷方式 */
prcf052       varchar2(1)      ,/* 是否整倍計算 */
prcf053       varchar2(8)      ,/* 起始時間 */
prcf054       varchar2(8)      ,/* 截止時間 */
prcf055       varchar2(10)      ,/* 換贈對象 */
prcf056       varchar2(10)      ,/* 換贈編號 */
prcf057       number(20,6)      ,/* 實際費用 */
prcf058       number(20,6)      /* 目標毛利金額 */
);
alter table prcf_t add constraint prcf_pk primary key (prcfent,prcf001) enable validate;

create unique index prcf_pk on prcf_t (prcfent,prcf001);

grant select on prcf_t to tiptop;
grant update on prcf_t to tiptop;
grant delete on prcf_t to tiptop;
grant insert on prcf_t to tiptop;

exit;
