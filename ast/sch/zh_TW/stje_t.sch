/* 
================================================================================
檔案代號:stje_t
檔案名稱:招商租賃合約單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table stje_t
(
stjeent       number(5)      ,/* 企业代码 */
stjesite       varchar2(10)      ,/* 营运组织 */
stjeunit       varchar2(10)      ,/* 制定組織 */
stje001       varchar2(20)      ,/* 合約編號 */
stje002       varchar2(10)      ,/* 版本 */
stje003       varchar2(20)      ,/* 合約項編號 */
stje004       varchar2(10)      ,/* 經營方式 */
stje005       varchar2(10)      ,/* 合約狀態 */
stje006       varchar2(20)      ,/* 文件編號 */
stje007       varchar2(10)      ,/* 商戶編號 */
stje008       varchar2(20)      ,/* 鋪位編號 */
stje009       varchar2(10)      ,/* 租賃類型 */
stje010       varchar2(255)      ,/* 門牌號 */
stje011       date      ,/* 租賃開始日期 */
stje012       date      ,/* 租賃結束日期 */
stje013       number(10,0)      ,/* 免租天數 */
stje014       varchar2(1)      ,/* 首零合併 */
stje015       varchar2(1)      ,/* 尾零合併 */
stje016       date      ,/* 簽訂日期 */
stje017       varchar2(20)      ,/* 簽訂人員 */
stje018       varchar2(10)      ,/* 簽訂部門 */
stje019       varchar2(10)      ,/* 樓棟編號 */
stje020       varchar2(10)      ,/* 樓層編號 */
stje021       varchar2(10)      ,/* 區域編號 */
stje022       varchar2(10)      ,/* 鋪位用途 */
stje023       number(20,6)      ,/* 建築面積 */
stje024       number(20,6)      ,/* 測量面積 */
stje025       number(20,6)      ,/* 經營面積 */
stje026       number(10,0)      ,/* 人數 */
stje027       varchar2(10)      ,/* no use */
stje028       varchar2(10)      ,/* 管理品類 */
stje029       varchar2(10)      ,/* 經營主品牌 */
stje030       varchar2(10)      ,/* 結算組織 */
stje031       varchar2(10)      ,/* 結算方式 */
stje032       varchar2(10)      ,/* 結算類型 */
stje033       varchar2(10)      ,/* 收銀方式 */
stje034       varchar2(10)      ,/* 付款條件 */
stje035       varchar2(10)      ,/* 交易條件 */
stje036       varchar2(10)      ,/* 幣別 */
stje037       varchar2(10)      ,/* 匯率計算基準 */
stje038       varchar2(10)      ,/* 稅別 */
stje039       varchar2(10)      ,/* 發票類型 */
stje040       varchar2(1)      ,/* 含發票否 */
stje041       date      ,/* 執行日期 */
stje042       date      ,/* 進場日期 */
stje043       date      ,/* 延期日期 */
stje044       date      ,/* 原合約開始日期 */
stje045       date      ,/* 清退日期 */
stje046       date      ,/* 作廢日期 */
stje047       date      ,/* 蓋章日期 */
stje048       varchar2(20)      ,/* 預租協議 */
stje049       varchar2(255)      ,/* 備註 */
stje050       date      ,/* 初審異動日期 */
stje051       varchar2(20)      ,/* 初審異動人員 */
stje052       date      ,/* 終審異動日期 */
stje053       varchar2(20)      ,/* 終審異動人員 */
stjestus       varchar2(10)      ,/* 狀態碼 */
stjeownid       varchar2(20)      ,/* 資料所屬者 */
stjeowndp       varchar2(10)      ,/* 資料所屬部門 */
stjecrtid       varchar2(20)      ,/* 資料建立者 */
stjecrtdp       varchar2(10)      ,/* 資料建立部門 */
stjecrtdt       timestamp(0)      ,/* 資料創建日 */
stjemodid       varchar2(20)      ,/* 資料修改者 */
stjemoddt       timestamp(0)      ,/* 最近修改日 */
stjecnfid       varchar2(20)      ,/* 資料確認者 */
stjecnfdt       timestamp(0)      ,/* 資料確認日 */
stjeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stjeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stjeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stjeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stjeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stjeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stjeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stjeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stjeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stjeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stjeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stjeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stjeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stjeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stjeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stjeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stjeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stjeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stjeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stjeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stjeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stjeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stjeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stjeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stjeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stjeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stjeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stjeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stjeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stjeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stje_t add constraint stje_pk primary key (stjeent,stje001) enable validate;

create unique index stje_pk on stje_t (stjeent,stje001);

grant select on stje_t to tiptop;
grant update on stje_t to tiptop;
grant delete on stje_t to tiptop;
grant insert on stje_t to tiptop;

exit;
