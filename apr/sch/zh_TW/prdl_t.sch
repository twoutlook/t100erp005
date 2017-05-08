/* 
================================================================================
檔案代號:prdl_t
檔案名稱:促銷規則單頭資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table prdl_t
(
prdlent       number(5)      ,/* 企業編號 */
prdlunit       varchar2(10)      ,/* 應用組織 */
prdlsite       varchar2(10)      ,/* 營運據點 */
prdl001       varchar2(20)      ,/* 規則編號 */
prdl002       varchar2(10)      ,/* 規則版本 */
prdl003       varchar2(10)      ,/* 規則類型 */
prdl004       varchar2(20)      ,/* 申請人員 */
prdl005       varchar2(10)      ,/* 申請部門 */
prdl006       varchar2(30)      ,/* 促銷方案 */
prdl007       varchar2(30)      ,/* 活動計劃 */
prdl008       varchar2(10)      ,/* 檔期類型 */
prdl009       varchar2(10)      ,/* 活動等級 */
prdl010       varchar2(1)      ,/* 全稱促銷 */
prdl011       varchar2(1)      ,/* 款別限制 */
prdl012       varchar2(1)      ,/* 折扣卡 */
prdl013       varchar2(1)      ,/* 日期高階設定 */
prdl014       number(10,0)      ,/* 組合總額/量 */
prdl015       varchar2(1)      ,/* 滿額分段否 */
prdl016       varchar2(1)      ,/* 參加換贈 */
prdl017       varchar2(10)      ,/* 換贈方式 */
prdl018       varchar2(10)      ,/* 計算方式 */
prdl019       varchar2(1)      ,/* 換贈設定模式 */
prdl020       varchar2(1)      ,/* 兼容換贈 */
prdl021       varchar2(10)      ,/* 換贈商品條件 */
prdl022       number(5,0)      ,/* 限定換贈種類 */
prdl023       number(5,0)      ,/* 限定換贈總數 */
prdl024       varchar2(10)      ,/* 促銷方式 */
prdl025       varchar2(10)      ,/* 入機方式 */
prdl026       varchar2(10)      ,/* 參與對象 */
prdl027       varchar2(40)      ,/* 促銷優先級 */
prdl028       varchar2(10)      ,/* 返利標準 */
prdl029       number(20,6)      ,/* 達成任務量返利率 */
prdl030       number(20,6)      ,/* 超出任務量返利率 */
prdl031       number(20,6)      ,/* 承擔比例 */
prdl032       varchar2(10)      ,/* 物返方式 */
prdl098       varchar2(10)      ,/* 營運業態 */
prdl099       varchar2(1)      ,/* 發佈否 */
prdl100       timestamp(0)      ,/* 發佈日期 */
prdlstus       varchar2(10)      ,/* 狀態碼 */
prdlownid       varchar2(20)      ,/* 資料所有者 */
prdlowndp       varchar2(10)      ,/* 資料所有部門 */
prdlcrtid       varchar2(20)      ,/* 資料建立者 */
prdlcrtdp       varchar2(10)      ,/* 資料建立部門 */
prdlcrtdt       timestamp(0)      ,/* 資料創建日 */
prdlmodid       varchar2(20)      ,/* 資料修改者 */
prdlmoddt       timestamp(0)      ,/* 最近修改日 */
prdlcnfid       varchar2(20)      ,/* 資料確認者 */
prdlcnfdt       timestamp(0)      ,/* 資料確認日 */
prdlud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdlud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdlud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdlud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdlud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdlud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdlud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdlud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdlud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdlud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdlud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdlud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdlud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdlud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdlud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdlud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdlud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdlud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdlud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdlud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdlud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdlud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdlud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdlud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdlud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdlud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdlud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdlud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdlud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdlud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prdl033       varchar2(10)      ,/* 活動類型 */
prdl034       varchar2(1)      ,/* 是否列印 */
prdldocno       varchar2(20)      ,/* 單號 */
prdl037       number(5,0)      ,/* 會員總達成次數 */
prdl038       varchar2(1)      ,/* 疊加否 */
prdl103       varchar2(10)      ,/* 來源程式 */
prdl039       varchar2(10)      ,/* 高階優惠方式 */
prdl040       varchar2(10)      ,/* 換贈依會員折扣後金額 */
prdl041       varchar2(10)      ,/* 換贈累計方式 */
prdl042       varchar2(1)      /* 當天銷售積分否 */
);
alter table prdl_t add constraint prdl_pk primary key (prdlent,prdl001) enable validate;

create unique index prdl_pk on prdl_t (prdlent,prdl001);

grant select on prdl_t to tiptop;
grant update on prdl_t to tiptop;
grant delete on prdl_t to tiptop;
grant insert on prdl_t to tiptop;

exit;
